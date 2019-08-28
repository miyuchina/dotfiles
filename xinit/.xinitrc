# vim:filetype=sh:

setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L=Escape"
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

if [[ "$(cat /proc/acpi/bbswitch | cut -d ' ' -f 2)" == "ON" ]]
then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --auto
    if [[ "$(xrandr --listmonitors | head -1 | cut -d ' ' -f 2)" != "1" ]]
    then
        xrandr --output HDMI-0 --right-of eDP-1-1 --scale 2x2
    fi
fi

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session bspwm
