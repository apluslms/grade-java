#!/bin/sh
set -eu

url=$1
file=${url##*/}

set --
for e in "" .sha1 .asc .asc.sha1; do
    set -- "$@" -O "$url$e"
done

if ! curl -LSs --fail --fail-early "$@"; then
    for e in "" .sha1 .asc .asc.sha1; do
        echo "  $url$e" >&2
    done
    exit 1
fi

for e in "" .asc; do
    echo "$(cat $file$e.sha1) $file$e" | sha1sum -c -
    rm "$file$e.sha1"
done

gpg --verify $file.asc 2>&1
rm $file.asc
