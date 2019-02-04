# basic settings
autoload -Uz colors
colors
bindkey -e

# no beep, no flow control (Ctrl-S), no logout (Ctrl-D)
setopt no_beep
setopt no_flow_control
setopt IGNOREEOF

# allow comments
setopt interactive_comments

# completion after '='
setopt magic_equal_subst

# print completion list
setopt auto_menu

# use glob
setopt extended_glob

# delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

#--------------------
# completion settings
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit && compinit

# highlight
zstyle ':completion:*:default' menu select

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# reverse traverse (keymap: Shift-Tab)
bindkey "^[[Z" reverse-menu-complete

#--------------------
# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*:*:cdr:*:*' menu selection
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-max 500
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
  zstyle ':chpwd:*' recent-dirs-pushd true
fi

#--------------------
# vcs_info & prompt
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "!"
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:*' formats "(%b)%u%c"
zstyle ':vcs_info:*' actionformats "(%b|%a)%u%c"
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="%B%F{green}%~%f %1(v|%F{blue}%1v %f|)$%b "

#--------------------
# environment variables
export EDITOR=vi
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# node
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH=$HOME
export PATH="$GOPATH/bin:$PATH"

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Google Cloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
export CLOUDSDK_PYTHON=/usr/bin/python2.7

# hub alias
eval "$(hub alias -s)"

# delete duplicated PATH for tmux
typeset -U path

#--------------------
# alias
case ${OSTYPE} in
  darwin*)
    alias ls='ls -FG'
    alias tac='tail -r'
    ;;
  linux*)
    alias ls='ls -F --color'
    ;;
esac

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
alias h='history'
alias kc='kubectl'

#--------------------
# fzf
export FZF_DEFAULT_COMMAND='ag --nocolor --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --no-sort'

# select history
function fzf-select-history() {
  BUFFER=$(history -n 1 | tac | fzf -q "${LBUFFER}")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# git branch
function fzf-git-recent-branches () {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
    perl -pne 's{^refs/(heads/)?}{}' | \
    fzf -q "${LBUFFER}")
  if [ -n "${selected_branch}" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-git-recent-branches
bindkey '^g' fzf-git-recent-branches

# cdr
function fzf-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf -q "${LBUFFER}")
  if [ -n "${selected_dir}" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cdr
bindkey '^]' fzf-cdr

# ghq
function fzf-ghq () {
  local selected_dir=$(ghq list --full-path | fzf -q "${LBUFFER}")
  if [ -n "${selected_dir}" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-ghq
bindkey '^\' fzf-ghq

#--------------------
# tmux auto start
if [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" ]]; then
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  else
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    else
      :  # Start terminal normally
    fi
  fi
fi
