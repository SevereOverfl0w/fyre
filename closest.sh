#!/bin/sh
#
# wildefyr & z3bra - 2014 (c) wtfpl
# find and focus the closest window in a specific direction

ARGS="$@"

usage() {
    cat << EOF
Usage: $(basename $0) [direction]
EOF

    test $# -eq 0 || exit $1
}

next_east() {
    (lsw; pfw) | sort | uniq | xargs wattr xi | sort -nr | sed "0,/$PFW/d" | \
        sed "1s/^[0-9]* //p;d"
}

next_west() {
    (lsw; pfw) | sort | uniq | xargs wattr xi | sort -n  | sed "0,/$PFW/d" | \
        sed "1s/^[0-9]* //p;d"
}

next_north() {
    (lsw; pfw) | sort | uniq | xargs wattr yi | sort -nr | sed "0,/$PFW/d" | \
        sed "1s/^[0-9]* //p;d"
}

next_south() {
    (lsw; pfw) | sort | uniq | xargs wattr yi | sort -n  | sed "0,/$PFW/d" | \
        sed "1s/^[0-9]* //p;d"
}

main() {
    . fyrerc.sh

    case $1 in
        h|east|left)  wid=$(next_east)  ;;
        j|south|down) wid=$(next_south) ;;
        k|north|up)   wid=$(next_north) ;;
        l|west|right) wid=$(next_west)  ;;
        *)            usage 0           ;;
    esac

    test ! -z $wid && focus.sh "$wid"
}

main $ARGS
