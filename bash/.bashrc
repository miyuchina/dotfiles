# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
shopt -s dirspell
shopt -s cdspell

PROMPT_COMMAND='history -a'

# aliases
alias v="nvim"
alias reboot="sudo runit-init 6"
alias shutdown="sudo runit-init 0"

function eu() {
    equery uses $@
}

function ev() {
    equery which $@ | xargs nvim
}

function kg() {
    zgrep -i "$@" /proc/config.gz
}

# fzf
. "/usr/share/fzf/key-bindings.bash"

# bash completion
. "/usr/share/bash-completion/bash_completion"
