#!/bin/sh
# Test functions of after-edit-diff.sh
getTestScript () {
	local script="$1";
	local testScript="/tmp/test-after-edit-diff.sh";
	cat "$script" \
	| sed 's/main "$@"/#main "$@"/' \
	> "$testScript";
	echo "$testScript";
	return 0;
}
getAbsolutePathTest () {
	getAbsolutePath "deleteme";
}
main () {
	local testScript="$(getTestScript "$SCRIPT")";
	. "$testScript"
	getAbsolutePathTest
}
set -e -u;
set -x;
SCRIPT="afterEditDiff.sh"
main "$@";
