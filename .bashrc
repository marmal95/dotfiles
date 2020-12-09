if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias ll='ls -al'
alias ..='cd ..'

export EDITOR=nvim

[ -f ~/.bash_libs/cplane.sh ] && source ~/.bash_libs/cplane.sh
[ -f ~/.bash_libs/utils.sh ] && source ~/.bash_libs/utils.sh
[ -f ~/.bash_libs/prompt.bash ] && source ~/.bash_libs/prompt.bash
