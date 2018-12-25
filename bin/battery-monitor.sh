#!/usr/bin/env bash

battery_level=$(acpi -b | head -1 | cut -d ' ' -f 4 | grep -o '[0-9]*')

if [ $battery_level -le 10 ]; then
    dunstify -u critical "Low Battery" "Your computer will go to sleep soon."
fi
