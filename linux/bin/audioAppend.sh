#!/bin/sh
TMP_DIR="/tmp/sh/audioAppend";
TMP_FILE="$TMP_DIR/tmpOutput.mp3";
main () {
	local outfile="$1"
	local file1="$2"

	prepare;
	if ! test -f "$outfile"; then
		cp "$file1" "$outfile";
	else
		echo | ffmpeg -f concat -i "$(getFfmpegInput "$outfile" "$file1")" -c copy "$(getNativePath "$TMP_FILE")" 1>/dev/null 2>/dev/null;
		mv "$TMP_FILE" "$outfile";
	fi
}
prepare () {
	ignore mkdir -p "$TMP_DIR";
	ignore rm "$TMP_FILE";
}
ignore () {
	"$@" 1> /dev/null 2> /dev/null \
	|| true;
	return 0;
}
forAll () {
	while
		read line
	do
		"$@" "$line"
	done
}
getFfmpegInput () {
	local file1; file1="$1"
	local file2; file2="$2"

	local inputFile; inputFile="$TMP_DIR/ffmpeg-concat-input"

	{ echo "$file1"; echo "$file2"; } |
	forAll getNativePath |
	sed "s/^/file '/" |
	sed "s/$/'/" \
	> "$inputFile"
	
	echo "$(getNativePath "$inputFile")"
	return
}
main "$@"; 
