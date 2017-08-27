####################
# basic settings
# use color
autoload -Uz colors
colors

# emacs keybind
bindkey -e

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

# no beep
setopt no_beep

# no Ctrl-S flow control
setopt no_flow_control

# no Ctrl-D logout
setopt IGNOREEOF

# correct wrong command
setopt correct

# allow comments
setopt interactive_comments

# completion after '='
setopt magic_equal_subst

# print completion list
setopt auto_menu

# use glob
setopt extended_glob

####################
# completion settings
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -C

# highlight
zstyle ':completion:*:default' menu select

# reverse traverse (keymap: Shift-Tab)
bindkey "^[[Z" reverse-menu-complete

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

####################
# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats '%u%c[%b]'
zstyle ':vcs_info:*' actionformats '%u%c[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

####################
# prompt
PROMPT="%B%F{black}%n%f %F{green}%~%f $%b "
RPROMPT="%B%1(v|%F{red}%1v%f|)%b"

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
  bindkey '^]' peco-ghq
fi

####################
# alias
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
alias h='history -15'

alias ls='ls -FG'
alias ll='ls -lFG'
alias la='ls -AFG'
alias lla='ls -lAFG'

####################
# tmux auto start
#if [ -z "$TMUX" -a -z "$STY" ]; then
#  if type tmux >/dev/null 2>&1; then
#    if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
#      tmux attach && echo "tmux attached session "
#    else
#      tmux new-session && echo "tmux created new session"
#    fi
#  elif type screen >/dev/null 2>&1; then
#    screen -rx || screen -D -RR
#  fi
#fi

