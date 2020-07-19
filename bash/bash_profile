# bash history
export HISTSIZE=50000
export HISTFILESIZE=10000
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="exit:ls:bg:fg:history"

# xdg stuff
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.local/cache"

# xdg fixes
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"             # gnupg
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"  # gtk-2.0
export INPUTRC="${XDG_CONFIG_HOME}/inputrc"             # readline
export LESSKEY="${XDG_CONFIG_HOME}/less/lesskey"        # lesskey
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"               # wget
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/pythonrc"      # python
export CCACHE_DIR="${XDG_CACHE_HOME}/ccache"            # ccache
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"    # less
export RXVT_SOCKET="${XDG_RUNTIME_DIR}/urxvtd"          # urxvt
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"       # xorg-xauth
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"            # rustup
export CARGO_HOME="${XDG_DATA_HOME}/cargo"              # cargo

# ccache
export PATH="/usr/lib/ccache/bin:${PATH}"

# rust
export PATH="${CARGO_HOME}/bin:${PATH}"

# local bin
export PATH="${HOME}/.local/bin:${PATH}"

# HiDPI scaling
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# firefox
export MOZ_USE_XINPUT2=1

# fzf
export FZF_DEFAULT_OPTS="
    --layout=reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:-1,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

export FZF_CTRL_T_OPTS="
    --ansi
    --preview-window 'right:60%'
    --preview 'bat --color always --theme ansi-dark {} 2> /dev/null || tree -aC {}'"

if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

if [[ "$(tty)" == "/dev/tty1" ]]; then
    exec startx "${XDG_CONFIG_HOME}/xorg/xinitrc"
fi
