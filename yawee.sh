#!/bin/mksh
#
# wildefyr & z3bra - 2015 (c) wtfpl
# catch window events from wew

source ~/.fyrerc

while IFS=: read ev wid; do
    case $ev in

        4)
            if ! wattr o $wid; then
                focus.sh $wid
            fi
            ;;

        16)
            if ! wattr o $wid; then
                winopen.sh $wid
                tile.sh
            fi
            ;;

        17)
            if [[ $previousWid != $wid ]]; then
                tile.sh
            fi
            ;;

        18)
            wattr $(pfw) || vroum.sh prev 2>/dev/null
            ;;

        19)
            if ! wattr o $wid; then
                setborder.sh inactive $wid
                focus.sh $wid
            fi
            ;;

    esac
    previousWid=$wid
done
