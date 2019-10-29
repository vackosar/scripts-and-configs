#!/bin/bash

if iwconfig |grep 'ESSID:"TIL-OFFICE'; then
  echo "turning off speaker volume";
  pactl -- suspend-sink 1 1;
fi
