#!/bin/bash

CLR_RESET="\e[0m"
CLR_TXT_BLACK="\e[0;30m"
CLR_TXT_DARK_RED="\e[0;31m"
CLR_TXT_DARK_GREEN="\e[0;32m"
CLR_TXT_BROWN="\e[0;33m"
CLR_TXT_DARK_BLUE="\e[0;34m"
CLR_TXT_DARK_PURPLE="\e[0;35m"
CLR_TXT_DARK_CYAN="\e[0;36m"
CLR_TXT_LIGHT_GRAY="\e[0;37m"
CLR_TXT_DARK_GRAY="\e[1;30m"
CLR_TXT_LIGHT_RED="\e[1;31m"
CLR_TXT_LIGHT_GREEN="\e[1;32m"
CLR_TXT_YELLOW="\e[1;33m"
CLR_TXT_LIGHT_BLUE="\e[1;34m"
CLR_TXT_LIGHT_PURPLE="\e[1;35m"
CLR_TXT_LIGHT_CYAN="\e[1;36m"
CLR_TXT_WHITE="\e[1;37m"

CLR_TXT_BOLD="\e[32;1m"
CLR_TXT_UNDERLINED="\e[4m"

CLR_TXT_BOLD="\e[32;1m"
CLR_TXT_UNDERLINED="\e[4m"

CLR_BLACK_ON_GREEN="\e[1;30;1;1;42m"
CLR_BLACK_ON_GREEN_BRIGHT="\e[1;30;5;1;42m"
CLR_CYAN_ON_GRAY="\e[1;36;5;1;40m"
CLR_BLACK_ON_CYAN="\e[1;30;1;1;46m"
CLR_BLACK_ON_CYAN_BRIGHT="\e[1;30;5;1;46m"

PROMPT_COMMAND="echo -ne \"\033]0;GRimShell -- $HOSTNAME\007\""

multigit_custom () {
    if [ -f out.txt ]; then
        rm out.txt
    fi

    ls -F --color=auto --show-control-chars -d */.git >> out.txt
    count=$(cat out.txt | wc -l)
    curr=1

    while read line; do
        line=${line%/.git/}
        echo -e $CLR_BLACK_ON_CYAN_BRIGHT"($curr/$count)" $line$CLR_RESET
        cd $line
        git "$@"
        cd ../
        echo ""
        curr=$((curr+1))
    done < out.txt
    rm out.txt
}
alias mg=multigit_custom

findfunc() {
    if test $# -lt 2; then
        echo "findfunc needs a minimum of 2 arguments"
        echo "1- File filter (must)"
        echo "2- Search string (must)"
        echo "3- Before/After buffer size (opt.)"
    fi

    if [ ! -z "$3" ]; then
        grep --color -nHri -C $3 "$2" --include=$1 .
    else
        grep --color -nHri "$2" --include=$1 .
    fi
}

# Fonction pour creer une branche passe en parametre
function new_branch() {
    local expectedParamCount=1
    if [[ "$#" -ne ${expectedParamCount} ]]; then
        echo -e ${CLR_TXT_LIGHT_RED}"new_branch a besoin de $expectedParamCount parametre"${CLR_RESET}
        echo -e ${CLR_TXT_LIGHT_CYAN}"Usage de la methode: "${CLR_RESET}
        echo -e ${CLR_TXT_LIGHT_CYAN}"\Nom de la branche"${CLR_RESET}
    else
        git checkout -b $1
        git push --set-upstream origin $1
    fi
}

# Fonction pour creer par multigit une branche passe en parametre
function new_branch_mg() {
    local expectedParamCount=1
    if test $# -ne ${expectedParamCount}; then
        echo -e ${CLR_TXT_LIGHT_RED}"new_branch_mg a besoin de $expectedParamCount parametre"${CLR_RESET}
        echo -e ${CLR_TXT_LIGHT_CYAN}"Usage de la methode: "${CLR_RESET}
        echo -e ${CLR_TXT_LIGHT_CYAN}"\Nom de la branche"${CLR_RESET}
    else
        mg checkout -b $1
        mg push --set-upstream origin $1
    fi
}

alias newbr='new_branch'
alias mnewbr='new_branch_mg'