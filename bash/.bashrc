# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell

alias ls='ls --color=auto'
alias v=nvim

PS1='[\u@\h \W]\$ '

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
