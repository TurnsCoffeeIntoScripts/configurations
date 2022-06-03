#/usr/bin/env bash

# SEE: https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial#:~:text=What%20is%20bash%20completion%3F,key%20while%20typing%20a%20command.


_cpm_completions()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi

    herp_derp+="abc "
    herp_derp+="def "
    herp_derp+="xyz "
    COMPREPLY=($(compgen -W "$pipelinesName" "${COMP_WORDS[1]}"))
}

complete -F _cpm_completions cpm