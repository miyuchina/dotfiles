#!/usr/bin/env bash

# === configuration ========================================

FONT="SF Mono:size=9"

SHOW_MONITOR_NAME=false

WIDTH=""
HEIGHT="60"
X_OFFSET=""
Y_OFFSET=""

# === colors ===============================================

BG_COLOR="#2E3440"
FG_COLOR="#E5E9F0"

FOCUSED_MONITOR_COLOR="#3B4252"
MONITOR_COLOR=""

ACTIVE_FOCUSED_OCCUPIED_COLOR="#BF616A"
ACTIVE_FOCUSED_URGENT_COLOR="#EBCB8B"
ACTIVE_FOCUSED_FREE_COLOR="#BF616A"

FOCUSED_OCCUPIED_COLOR="#5E81AC"
FOCUSED_URGENT_COLOR="#EBCB8B"
FOCUSED_FREE_COLOR="#5E81AC"

ACTIVE_OCCUPIED_COLOR="#434C5E"
ACTIVE_URGENT_COLOR="#EBCB8B"
ACTIVE_FREE_COLOR=""

OCCUPIED_COLOR="#3B4252"
URGENT_COLOR="#EBCB8B"
FREE_COLOR=""

# === script ===============================================

shopt -s extglob

BG_COLOR=${BG_COLOR:-#000000}
FG_COLOR=${FG_COLOR:-#ffffff}

colorize_workspace() {
    varname="$(echo "${1^^}" | sed 's/ /_/g')_COLOR"
    color=${!varname}
    echo \
        "%{B${color:-${BG_COLOR}}} $2 %{B${BG_COLOR}}"
}

workspaces() {
    result=""
    active_monitor=false
    IFS=':' read -a array <<< $(bspc wm --get-status)
    for item in "${array[@]#W}"; do
        name=${item##+([mofuMOFU])}
        if [[ "${item}" =~ [ofuOFU] ]]; then
            stat=""
            case $item in
                O*) stat="focused occupied" ;;
                U*) stat="focused urgent"   ;;
                F*) stat="focused free"     ;;
                o*) stat="occupied"         ;;
                u*) stat="urgent"           ;;
                f*) stat="free"             ;;
            esac
            [ "${active_monitor}" = true ] && stat="active ${stat}"
        elif [[ "${item}" =~ [mM] ]]; then
            case $item in
                M*) active_monitor=true;  stat="focused monitor" ;;
                m*) active_monitor=false; stat="monitor"         ;;
            esac
            [ "${SHOW_MONITOR_NAME}" = false ] && continue
        else
            continue
        fi
        colorized="$(colorize_workspace "${stat}" "${name}")"
        result="${result}${colorized}"
    done
    echo "${result}"
}

volume() {
    echo "VOL $(amixer get Master | tail -1 | grep -o "[0-9]\+%")"
}

battery() {
    ac_adapter="$(acpi --ac-adapter | cut -d ':' -f 2 | xargs)"
    percentage="$(acpi --battery | cut -d ',' -f 2 | head -1 | xargs)"
    if [[ "${ac_adapter}" == "on-line" ]]; then
        charging="CHR"
    else
        charging="BAT"
    fi
    echo "${charging} ${percentage}"
}

while [ "$(pidof bspwm)" != "" ]; do
    echo \
        "%{l}$(workspaces)" \
        "%{c}$(date +'%F %H:%M')" \
        "%{r}$(volume)" \
        "| $(battery)" \
        " "
    sleep 0.2
done |
lemonbar \
    -p \
    -f "${FONT}" \
    -g "${WIDTH}x${HEIGHT}+${X_OFFSET}+${Y_OFFSET}" \
    -B "${BG_COLOR}" \
    -F "${FG_COLOR}"
