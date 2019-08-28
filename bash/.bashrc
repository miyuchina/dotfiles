# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
shopt -s dirspell
shopt -s cdspell

alias ls='ls --color=auto'
alias v="nvim"

# fzf
source "${LOCALPATH}/share/fzf/shell/key-bindings.bash"
source "${LOCALPATH}/share/fzf/shell/completion.bash"

# pandoc
eval "$(pandoc --bash-completion)"
