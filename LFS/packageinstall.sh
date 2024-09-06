#!/bin/bash
CHAPTER="$1"
PACKAGE="$2"
cat package.csv | grep -i "^$PACKAGE;" | grep -i -v "\.patch;" | while read line; do
    NAME="`echo $line | cut -d\; -f1`"
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3`"
    # MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME=$(echo "$CACHEFILE" | sed 's/\(.*//)')
done