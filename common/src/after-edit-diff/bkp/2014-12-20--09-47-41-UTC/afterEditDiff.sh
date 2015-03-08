#!/bin/sh
# text editor wrapper which consults diff changes with you
getEncoded () {
	local path="$1"
	
	echo "$path" \
	| sed 's./.--.g'
}
isDiff () {
	local path="$1"
	local tmpPath="$2"
	diff -q "$path" "$tmpPath" 1>/dev/null 2>/dev/null
	return "$?"
}
printDiff () {
	local path="$1"
	local tmpPath="$2"
	diff -u "$path" "$tmpPath" \
	| less -S
}
validatePath () {
	local path="$1"
	local dir="$(dirname "$path")"
	if [ -d "$path" ]; then
		err "Cannot edit directory $path." > /dev/stderr
	fi
	if [ -f "$dir" ]; then
		err "Parent directory does not exist for file $path." > /dev/stderr
	fi
}
# Returns absolute path even if file does not exists.
getAbsolutePath () {
	local relativePath="$1";
	local dir="$(readlink -f "$(dirname "$relativePath")")";
	local filename="$(basename "$relativePath")";
	echo "$dir/$filename";
	return 0;
}
main () {
	local relativePath="$1";
	validatePath "$relativePath";
	local path="$(getAbsolutePath "$relativePath")";
	local tmpPath="$TMP_FILE_PREFIX$(getEncoded "$path")";
	if [ -f "$path" ]; then
		cp "$path" "$tmpPath"
	fi
	"$EDITOR" "$tmpPath"
	if isDiff "$path" "$tmpPath"; then
		echo "No change made. File will not be saved."
		return 0
	fi
	printDiff "$path" "$tmpPath"
	echo "Save file? [yn]"
	read save
	if [ "$save" = "y" ]; then
		echo "Saving file."
		mv "$tmpPath" "$path"
		return 0
	fi
	echo "File will not be saved. Removing editted file."
	rm "$tmpPath"
	return 0
}
set -u -e;
#set -x;
. loglib.sh;
EDITOR="vi";
TMP_FILE_PREFIX="/tmp/afterEditDiffFile-";
main "$@";
