# bash history
HISTSIZE=50000
HISTFILESIZE=10000

HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="exit:ls:bg:fg:history"

# local bin
export PATH="${HOME}/.local/bin:${PATH}"

# firefox
export MOZ_USE_XINPUT2=1

# vim settings
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim

# gpg settings
export GNUPGHOME="$HOME/.config/gnupg"

# pass settings
export PASSWORD_STORE_DIR="$HOME/.config/pass"

# fzf settings
export FZF_DEFAULT_OPTS="
    --layout=reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:-1,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

export FZF_CTRL_T_OPTS="
    --ansi
    --preview-window 'right:60%'
    --preview 'bat --line-range :100 {} 2> /dev/null || tree -C {}'"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ $(tty) == '/dev/tty1' ]; then
    startx
fi
