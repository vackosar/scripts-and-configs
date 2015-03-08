#!/bin/sh
set -e -u
#set -x

main () {
	local outfile; outfile="$1"
	local file1; file1="$2"
	local file2; file2="$3"

	ffmpeg -f concat -i "$(getFfmpegInput "$file1" "$file2")" -c copy "$(getNativePath "$outfile")"
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

	local inputFile; inputFile="/tmp/ffmpeg-concat-input"

	{ echo "$file1"; echo "$file2"; } |
	forAll getNativePath |
	sed "s/^/file '/" |
	sed "s/$/'/" \
	> "$inputFile"
	
	echo "$(getNativePath "$inputFile")"
	return
}
main "$@"
