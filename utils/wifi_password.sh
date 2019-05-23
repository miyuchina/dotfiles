#!/usr/bin/env bash

CONFIG="wpa_supplicant/wpa_supplicant.conf"
TARGET="/etc/wpa_supplicant/wpa_supplicant.conf"

set -e

echo -n "WiFi password: "
read -s password
echo

sed "s/password=.*/password=\""${password}"\"/1g" "${CONFIG}" |\
    sudo tee "${TARGET}"

