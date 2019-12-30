# vim:filetype=sh:

setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L=Escape"
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

exec bspwm
