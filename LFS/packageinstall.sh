#!/bin/bash
CHAPTER="$1"
PACKAGE="$2"
cat package.csv | grep -i "^$PACKAGE;" | grep -i -v "\.patch;" | while read line; do
    NAME="`echo $line | cut -d\; -f1`"
    export VERSION="`echo $line | cut -d\; -f2`"
    export URL="`echo $line | cut -d\; -f3`"
    # MD5SUM="`echo $line | cut -d\; -f4`"
    export CACHEFILE="$(basename "$URL")" #now inform of .tar

    #get dirname of package is install
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"

    if [ -d "$DIRNAME" ]; then 
        rm -rf "$DIRNAME"
    fi
    mkdir -pv "$DIRNAME"


    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME"
        if [ "$(ls -1A | wc -l)" = "1" ]; then
            mv $(ls -1A)/* ./
        fi    

        #run script to build
        echo "Compiling $PACKAGE"
        sleep 5

        mkdir -pv "../log/chapter$CHAPTER/"

        if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then
            echo "Compiling $PACKAGE FAILED!"
            popd
            exit 1
        fi
        
        echo "Done compiling $PACKAGE"
    popd
done