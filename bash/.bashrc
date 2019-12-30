# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
shopt -s dirspell
shopt -s cdspell

PROMPT_COMMAND='history -a'

alias ls='ls --color=auto'
alias v="nvim"

# fzf
source "${HOME}/.local/share/fzf/shell/key-bindings.bash"
source "${HOME}/.local/share/fzf/shell/completion.bash"
