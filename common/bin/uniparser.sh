#!/bin/sh
java -jar "$(getNativePath "$cloud/src/Uniparser/target/uniparser.jar")" "$@"
