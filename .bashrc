# alias
alias ls='ls -FG'
alias ll='ls -lFG'
alias la='ls -AFG'

alias mv='mv -i'
alias cp='cp -i'
#alias rm='rm -i'

alias pu='pushd'
alias po='popd'
alias d='dirs -v'
alias h='history 20'

alias be='bundle exec'
alias bi='bundle install'

# terminal color
export TERM=xterm-256color

# postgres
#export PGDATA=/usr/local/var/postgres

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/

# MacPorts Installer addition on 2013-07-14_at_11:19:39: adding an appropriate PATH variable for use with MacPorts.
#if [[ ! $PATH =~ /opt/local/bin:/opt/local/sbin: ]]; then
#	export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#fi
# Finished adapting your PATH environment variable for use with MacPorts.
