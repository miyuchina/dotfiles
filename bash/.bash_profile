# bash history
export HISTSIZE=50000
export HISTFILESIZE=10000

export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="exit:ls:bg:fg:history"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# local bin
export PATH="${HOME}/.local/bin:${PATH}"

# HiDPI scaling
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# firefox
export MOZ_USE_XINPUT2=1

# vim settings
export EDITOR=nvim

# gpg settings
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# pass settings
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME}/pass"

# fzf settings
export PATH="${HOME}/.local/share/fzf/bin:${PATH}"

export FZF_DEFAULT_OPTS="
    --layout=reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:-1,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

export FZF_CTRL_T_OPTS="
    --ansi
    --preview-window 'right:60%'
    --preview 'highlight --out-format=xterm256 --style=pablo {} 2> /dev/null || tree -C {}'"

[[ -f ~/.bashrc ]] && . ~/.bashrc
