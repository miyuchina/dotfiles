# bash history
export HISTSIZE=50000
export HISTFILESIZE=10000

export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="exit:ls:bg:fg:history"

export LOCALPATH="${HOME}/.local"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# local bin
export PATH="${LOCALPATH}/bin:${PATH}"
export MANPATH="${XDG_DATA_HOME}/man:${MANPATH}"

# latex
export PATH="${XDG_DATA_HOME}/texlive/2019/bin/x86_64-linux:${PATH}"
export MANPATH="${XDG_DATA_HOME}/texlive/2019/texmf-dist/doc/man:${MANPATH}"
export INFOPATH="${XDG_DATA_HOME}/texlive/2019/texmf-dist/doc/info:${INFOPATH}"

# firefox
export MOZ_USE_XINPUT2=1

# vim settings
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim

# gpg settings
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# pass settings
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME}/pass"

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
