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
Red='\[\e[1;32m\]'
Gre='\[\e[1;32m\]'
BYel='\[\e[1;33m\]'
BBlu='\[\e[1;34m\]'
Pur='\[\e[1;35m\]'


# Status of last command (for prompt)
__build_ps1_user_name() {
    local EXIT="$?"             # This needs to be first

    local result=''
    if [ $EXIT != 0 ]; then
        result+="${Red}[\u]${RCol}"
    else
        result+="${Gre}[\u]${RCol}"
    fi

    echo $result
}

function __build_ps1_host_name() {
    local result="${RCol}${BBlu}[\h]"
    echo $result
}

function __build_virtualenv_name() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="[${VIRTUAL_ENV##*/}]"
    else
        # In case you don't have one activated
        venv=''
    fi

    local Color_On=${BYel}
    echo "${Color_On}$venv${RCol}"
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

function __build_directory_name() {
    local result="${Pur}[\W]${RCol}"
    echo $result
}

__prompt_command() {
    PS1=$(__build_ps1_user_name)
    PS1+=$(__build_ps1_host_name)
    PS1+=$(__build_virtualenv_name)
    PS1+=$(__build_directory_name)
    PS1+=' '
    export PS1
}

