# vim:filetype=sh:

setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L=Escape"
xrdb -merge ~/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

udiskie &

exec i3
