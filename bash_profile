#
# ~/.bash_profile
#

# qt 5 hidpi
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# vim settings
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim

# firefox touchscreen scroll
export MOZ_USE_XINPUT2=1

# rust / cargo
export PATH="$HOME/.cargo/bin:$PATH"

# npm global packages
export NPM_CONFIG_PREFIX="$HOME/.npm-packages"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# gpg settings
export GNUPGHOME="$HOME/.config/gnupg"

# pass settings
export PASSWORD_STORE_DIR="$HOME/.config/pass"

# fzf settings
export FZF_DEFAULT_OPTS="
    --border
    --height 30%
    --layout=reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

export FZF_CTRL_T_OPTS="
    --ansi
    --preview-window 'right:60%'
    --preview 'bat --line-range :100 {} 2> /dev/null || tree -C {}'"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ $(tty) == '/dev/tty1' ]; then
    startx
fi
