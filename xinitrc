# vim:filetype=sh:

# --- magic capslock ------------------------
setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L-Escape"
xrdb -merge ~/.Xresources

# --- dunst ---------------------------------
systemctl --user set-environment DISPLAY-:0

# --- qt5 theme -----------------------------
export QT_QPA_PLATFORMTHEME="qt5ct"

# --- input method --------------------------
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
pkill fcitx; fcitx &

# --- auto-mount ----------------------------
pkill udiskie; udiskie &

# --- i3 ------------------------------------
exec i3
