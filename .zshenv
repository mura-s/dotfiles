# PATH
# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# go
export GOPATH=$HOME

# ghq PATH
export PATH="$GOPATH/bin:$PATH"

# node
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# hub alias
eval "$(hub alias -s)"

# delete duplicated PATH for tmux
typeset -U path

# editor
export EDITOR=vi

# LANG
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home

# postgres
export PGDATA=/usr/local/var/postgres
export ARCHFLAGS="-arch x86_64"

