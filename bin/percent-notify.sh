#!/usr/bin/env bash

set -e

print_body() {
    icon="$1"
    percentage="${2%.*}"  # convert to integer

    bars="$(printf '%*s' $(( percentage / 5 )) | tr ' ' '#')"
    spaces="$(printf '%*s' $(( 20 - percentage / 5 )))"

    progress="${bars}${spaces}"
    percentage_text="$(printf "%4d" $percentage)"

    echo "<span font_family='Consolas'>${icon} ${progress}</span> ${percentage_text}%"
}

SUMMARY="$1"
ICON="$2"
PERCENTAGE="$3"

dunstify -r 1000 "${SUMMARY}" "$(print_body ${ICON} ${PERCENTAGE})"
