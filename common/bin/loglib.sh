#!/bin/sh
err () {
	echo "ERROR: $@" 1>&2
	return 1
}
warn () {
	echo "WARN: $@" 1>&2
}
info () {
	if [ -n "$verbose" ]; then
	  echo "INFO: $@" 1>&2
  fi
}
