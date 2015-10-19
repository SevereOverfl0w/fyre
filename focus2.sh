#!/bin/mksh
#
# z3bra - 2014 (c) wtfpl
# Window focus wrapper that sets borders and can focus next/previous window

source fyrerc.sh

usage() {
    echo "usage: $(basename $0) <next|prev|wid>"
    exit 1
}

case $1 in
    next) wid=$(lsw|grep -v $CUR|sed '1 p;d') ;;
    prev) wid=$(lsw|grep -v $CUR|sed '$ p;d') ;;
    0x*) wattr $1 && wid=$1 ;;
    *) usage ;;
esac

# exit if we can't find another window to focus
test -z "$wid" && echo "$(basename $0): can't find a window to focus" >&2 && exit 1

wtf $wid
