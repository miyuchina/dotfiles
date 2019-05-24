# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell

alias ls='ls --color=auto'
alias v=nvim

# fzf
source "${HOME}/.local/share/fzf/key-bindings.bash"
source "${HOME}/.local/share/fzf/completion.bash"

function cd {
    builtin cd "$@" && ls
}
