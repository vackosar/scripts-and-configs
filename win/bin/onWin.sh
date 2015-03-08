#!/bin/dash
set -e
#set -x
script="$(readlink -f "$(cygpath -u "$1")")"
directory="$(readlink -f "$(cygpath -u "$(dirname "$2")")")"
echo "Executing script: $script"
echo "In directory: $directory"
echo
cd "$directory"
. /cygdrive/c/dev/bin/.profile_cygwin
if
	! dash "$script"
then
	echo "Process returned error. Press enter to exit"
	read tmp
fi