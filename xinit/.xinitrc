# vim:filetype=sh:

export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

eval "$(dbus-launch --sh-syntax --exit-with-session)"
fcitx &

exec bspwm
