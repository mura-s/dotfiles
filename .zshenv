# PATH
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# ghq PATH
export PATH="$HOME/bin:$PATH"

# hub alias
eval "$(hub alias -s)"

# delete duplicated PATH for tmux
typeset -U path

# terminal color
export TERM=xterm-256color
export CLICOLOR=1
# ls color
export LSCOLORS="gxfxcxdxbxegedabagacad"
# completion color
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# editor
export EDITOR=vi

# LANG
export LANG=ja_JP.UTF-8

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home

# go
export GOPATH=$HOME

# docker
export DOCKER_HOST=tcp://192.168.59.103:2375

# postgres
#export PGDATA=/usr/local/var/postgres
