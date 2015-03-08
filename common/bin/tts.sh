#!/bin/bash

# requieres audioAppend.sh
TMP_DIR="/tmp/googleTts";
TMP_OUTPUT="$TMP_DIR/output.mp3";
main () {
	local lang;
	if [ "$#" -ge 1 ]; then
		lang="$1";
	else
		lang="en";
	fi
	local outfile;
	if [ "$#" = 2 ]; then
		outfile="$2"
	else
		outfile=""
	fi
	prepare
	forAll get "$lang";
	if [ -z "$outfile" ]; then
		play "$TMP_OUTPUT";
	else
		mv "$TMP_OUTPUT" "$outfile";
		echo "Output written to $outfile";
	fi
	cleanUp
}
get () {
	local lang="$1"
	local text="$2"
	if [ -z "$text" ]; then
		silence 1;
	elif isSleepLine "$text"; then
		silence "$(getSecondsFromSleepLine "$text")";
	else
		local tmpFile="$TMP_DIR/tmp.mp3";
		wget -q -U Mozilla -O "$tmpFile" "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$text"
		audioAppend.sh "$TMP_OUTPUT" "$tmpFile";
		ignore rm "$tmpFile";
	fi
}
getSecondsFromSleepLine () {
	local sleepLine="$1";
	
	echo "$sleepLine" |
	sed "s/^@sleep \([0-9]\+\)/\1/"	
}
isSleepLine () {
	local text="$1";
	echo "$text" |
	success grep "^@sleep [0-9]\+";
	return "$?";
}
SILENCE_1S_FILE="$cloud/opn/learn/rsr/silence1s.mp3";
silence () {
	local seconds="$1";
	seq "$(($seconds/2))" |
	while read second; do
		audioAppend.sh "$TMP_OUTPUT" "$SILENCE_1S_FILE";
	done;
}
success () {
	"$@" 1> /dev/null 2> /dev/null;
	return "$?";
}
ignore () {
	"$@" 1> /dev/null 2> /dev/null \
	|| true;
	return 0;
}
forAll () {
	while IFS='' read -r line; do
		echo "INFO: now tts line: $line";
		"$@" "$line";
	done
}
prepare () {
	ignore mkdir -p "$TMP_DIR";
	cleanUp;
}
cleanUp () {
	ignore rm "$TMP_OUTPUT";
}
set -e -u
#set -x
main "$@"
