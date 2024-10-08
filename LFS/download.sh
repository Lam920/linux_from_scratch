cat package.csv | while read line; do
    NAME="`echo $line | cut -d\; -f1`"
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3`"
    MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    # echo NAME $NAME
    # echo VERSION $VERSION
    # echo URL $URL
    # echo MD5SUM $MD5SUM
    # echo CACHEFILE $CACHEFILE
    if [ ! -f "$CACHEFILE" ]; then
        echo "Downloading $URL"
        wget "$URL"
        if ! echo "$MD5SUM $CACHEFILE" | md5sum -c > /dev/null; then
            rm -f "$CACHEFILE"
            echo "Verification of $CACHEFILE failed! MD5 mismatch"
            exit 1
        fi
    fi
done