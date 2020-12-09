# If not running interactively, don't do anything
# in order not to break scp protocol with newline echo trap

########################################################################################################

case $- in
    *i*) ;;
    *) return;;
esac

########################################################################################################
PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

RCol='\[\e[0m\]'
Red='\[\e[0;31m\]'
Gre='\[\e[0;32m\]'
BYel='\[\e[1;33m\]'
BBlu='\[\e[1;34m\]'
Pur='\[\e[0;35m\]'


# Status of last command (for prompt)
__build_ps1_status() {
    local EXIT="$?"             # This needs to be first

    local result=''
    if [ $EXIT != 0 ]; then
        result+="${Red}[\u]${RCol}"
    else
        result+="${Gre}[\u]${RCol}"
    fi

    echo $result
}

__build_ps1_user_directory_info() {
    local result="[${RCol}${BBlu}\h ${Pur}\W${RCol}]"
    echo $result
}

function __git_prompt() {

    local git_status="`git status -unormal 2>&1`"

    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=${Gre}
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=${Pur}
        else
            local Color_On=${Red}
        fi

        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi

        echo "${Color_On}[$branch]${RCol}"
    fi
}

__prompt_command() {
    PS1=$(__build_ps1_status)
    PS1+=$(__build_ps1_user_directory_info)
    #PS1+=$(__git_prompt)
    PS1+=' '
    export PS1
}

