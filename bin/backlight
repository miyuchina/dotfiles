#!/usr/bin/env bash

set -e

BACKLIGHT_DIR="/sys/class/backlight/intel_backlight"
BRIGHTNESS="$BACKLIGHT_DIR/brightness"
MAX_BRIGHTNESS="$BACKLIGHT_DIR/max_brightness"

AWK_CMD='{
    curr_percentage = $3 / $4

    if ($1 == "+")
        new_percentage = curr_percentage + $2 / 100
    else if ($1 == "-")
        new_percentage = curr_percentage - $2 / 100
    else
        new_percentage = curr_percentage

    if (new_percentage > 1)
        new_percentage = 1
    else if (new_percentage < 0)
        new_percentage = 0

    print int( new_percentage * $4 )
}'

current() {
    cat "${BRIGHTNESS}" "${MAX_BRIGHTNESS}" | xargs | awk '{print $1 / $2}'
}

adjust() {
    echo "$1 $2 $(cat ${BRIGHTNESS}) $(cat ${MAX_BRIGHTNESS})" | awk "${AWK_CMD}" | tee $BRIGHTNESS
}

main() {
    if [[ $1 =~ \+[[:digit:]]+ ]]; then
        adjust + ${1//+}
    elif [[ $1 =~ \-[[:digit:]]+ ]]; then
        adjust - ${1//-}
    else
        current
    fi
}

main $@
