#!/bin/bash
set -e

OPTARG="$(echo "$@" | sed 's;^\-c ;;')"
if echo "$OPTARG" | grep -q '^\(scp\|rsync\)[^&;|]*$'; then
  $OPTARG
fi
