#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias ls='ls --color=auto'
alias la='ls -al --color=auto'
alias grep='grep --color=auto'
alias targz="tar -xzf"

PS1='[\u@\h \W]\$ '

#Start starship
eval "$(starship init bash)"

#Enviroment Variables
export PATH="/mnt/repository/bin/linux:$PATH"

#Add git autocompletion
source /usr/share/git/completion/git-completion.bash