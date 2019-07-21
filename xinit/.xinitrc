# vim:filetype=sh:

setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L=Escape"
xrdb -merge ~/.Xresources
xsetroot -xcf /usr/share/cursors/xorg-x11/Adwaita/cursors/left_ptr 48

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session bspwm
