####################
# basic settings
# use color
autoload -Uz colors
colors

# emacs keybind
bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# prompt
PROMPT="%F{blue}[%n@%m]%f%F{yellow} %~
%f> "

# delimiter
autoload -Uz select-word-style
select-word-style default
# add delimiter
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

####################
# completion settings
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -C

# node
if [ -f /usr/local/share/zsh/site-functions/_npm ]; then
  source /usr/local/share/zsh/site-functions/_npm
fi

# color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# highlight
zstyle ':completion:*:default' menu select

# reverse traverse (keymap: Shift-Tab)
bindkey "^[[Z" reverse-menu-complete

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignore parents
zstyle ':completion:*' ignore-parents parent pwd ..

# for sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

####################
# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats '%u%c[%s:%b]'
zstyle ':vcs_info:*' actionformats '%u%c[%s:%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# set RPROMPT
RPROMPT="%1(v|%F{magenta}%1v%f|)"

####################
# option settings
# print japanese file name
setopt print_eight_bit

# no beep
setopt no_beep

# no flow control
setopt no_flow_control

# no Ctrl-D logout
setopt IGNOREEOF

# correct wrong command
setopt correct

# allow comments
setopt interactive_comments

# cd and pushd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks

# completion after '='
setopt magic_equal_subst

# print completion list
setopt auto_menu

# use glob
setopt extended_glob

####################
# keybind
# history search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

####################
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

####################
# alias
alias mv='mv -i'
alias cp='cp -i'

alias grep='grep --color'

alias pu='pushd'
alias po='popd'
alias d='dirs -v'
alias h='history -15'

alias be='bundle exec'
alias bi='bundle install --path vendor/bundle'
alias bu='bundle update'
alias bl='bundle list'

case "${OSTYPE}" in
darwin*)
	alias ls='ls -FG'
	alias ll='ls -lFG'
	alias la='ls -AFG'
	;;
linux*)
	alias ls='ls -F --color=auto'
	alias ll='ls -lF --color=auto'
	alias la='ls -AF --color=auto'
	;;
esac

####################
# peco
function exists { which $1 &> /dev/null }

if exists peco; then
  # select history
  function peco-select-history() {
    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  # cdr
  function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-cdr
  bindkey '^[' peco-cdr

  # git branch
  function peco-git-recent-all-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
      perl -pne 's{^refs/(heads/)?}{}' | \
      peco --query "$LBUFFER")
    if [ -n "$selected_branch" ]; then
      BUFFER="git checkout ${selected_branch}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-git-recent-all-branches
  bindkey '^g' peco-git-recent-all-branches

  # ghq
  function peco-ghq () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-ghq
  bindkey '^\' peco-ghq

  # select ssh host
  function peco-select-host () {
    local selected_host=$(grep -vE '(^#|^$|localhost)' /private/etc/hosts | \
      awk '{print $2}' | \
      peco --query "$LBUFFER")
    if [ -n "$selected_host" ]; then
      BUFFER="ssh ${selected_host}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-select-host
  bindkey '^]' peco-select-host
fi

####################
# tmux auto start
if [ -z "$TMUX" -a -z "$STY" ]; then
  if type tmux >/dev/null 2>&1; then
    if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
      tmux attach && echo "tmux attached session "
    else
      tmux new-session && echo "tmux created new session"
    fi
  elif type screen >/dev/null 2>&1; then
    screen -rx || screen -D -RR
  fi
fi
