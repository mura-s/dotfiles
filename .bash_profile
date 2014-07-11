# bashrc
if [ -f ~/.bashrc ] ; then
	source ~/.bashrc
fi

# PATH
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
