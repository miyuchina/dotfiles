#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# vim settings
alias  vim=nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim

# prompt
PROMPT_COMMAND=__prompt_cmd

__prompt_cmd() {
    # store off last exit code
    local EXIT="$?"
    PS1=""

    # colors!
    local RED='\[\e[0;31m\]'
    local GRE='\[\e[0;32m\]'
    local YEL='\[\e[0;33m\]'
    local BLU='\[\e[0;34m\]'
    local PUR='\[\e[0;35m\]'
    local CYA='\[\e[0;36m\]'

    local B_RED='\[\e[1;31m\]'
    local B_GRE='\[\e[1;32m\]'
    local B_BLU='\[\e[1;34m\]'

    local END='\[\e[0m\]'

    # venv
    if [ ! -z "$VIRTUAL_ENV" ]; then
        PS1+="${CYA} ${END}"
    fi

    # git stuff
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then  # if we are in working tree
        if [[ -n $(git status --porcelain) ]]; then                # check if the directory is dirty
            PS1+="${RED} ${END}"
        fi
        PS1+="${YEL} `git rev-parse --abbrev-ref HEAD 2> /dev/null`${END} "  # output branch name
    fi

    # prompt
    if [ $EXIT != 0 ] && [ $EXIT != 148 ]; then
        PS1+="${B_RED} ${END}"
    else
        PS1+="${B_GRE} ${END}"
    fi
}

ethernet() {
    sudo netctl stop-all
    sudo systemctl start dhcpcd
    sudo ip link set up enp0s31f6
}

wifi() {
    sudo systemctl stop dhcpcd
    sudo ip link set down enp0s31f6
    sudo ip link set down wlp0s20f3
    sudo netctl start wlp0s20f3-Williams
}
