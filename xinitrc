# vim:filetype=sh:

# --- magic capslock ------------------------
setxkbmap -option 'caps:hyper'
xcape -e "Hyper_L=Escape"
xrdb -merge ~/.Xresources

# --- dunst ---------------------------------
#systemctl --user set-environment DISPLAY-:0
#pkill dunst; dunst &

# --- qt5 theme -----------------------------
export QT_QPA_PLATFORMTHEME="qt5ct"

# --- input method --------------------------
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#pkill fcitx; fcitx &

# --- auto-launch ---------------------------
#pkill udiskie;  udiskie &
pkill compton;  compton &
#pkill redshift; redshift &

xrandr --auto
xrandr --output HDMI-0 --scale 2x2 --right-of eDP-1-1
/home/mi/.fehbg

# --- window manager ------------------------
exec i3
