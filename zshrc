#=============================================================================
#     FileName: zshrc
#         Desc: install my zshrc
#       Author: KuoE0
#        Email: kuoe0.tw@gmail.com
#     HomePage: http://kuoe0.ch/
#      Version: 0.0.1
#   LastChange: 2012-09-25 12:35:39
#      History:
#=============================================================================
export TERM=xterm-256color
################################################################################
# get OS name
OS=$(uname)
################################################################################
# Path setting
export PATH="~/Workspace/KuoE0-utils:$PATH"

# Path config for Mac OS X
if [ "$OS" = 'Darwin' ]; then
	# path of GNU coreutils
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	# use python of homebrew
	export PATH="/usr/local/share/python:$PATH"
	# use package of homebrew
	export PATH="/usr/local/bin:$PATH"
	export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	# add gfortran dynamic lib path to DYLD_LIBRARY_PATH variable
	export DYLD_LIBRARY_PATH=/usr/local/Cellar/gfortran/4.8.0/gfortran/lib/ 
fi

################################################################################
# Path of oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# theme name (theme in .oh-my-zsh/theme)
ZSH_THEME="powerline"

# setup plugin (plugin in .oh-my-zsh/plugin)
plugins=()

if [ "$OS" = 'Linux' ]; then	# Linux

elif [ "$OS" = 'Darwin' ]; then		# Mac OS X
	plugins+=osx
	# check homebrew
	if which brew &> /dev/null; then
		plugins+=brew
	fi
	# check macports
	if which port &> /dev/null; then
		plugins+=port
	fi
fi

# check git
if which git &> /dev/null; then
	plugins+=git
	# configuration git
	git config --global user.name "KuoE0"
	git config --global user.email "kuoe0.tw@gmail.com"
	git config --global core.editor `which vim`		# let git use the correct vim on Mac
	git config --global color.ui auto # colorize git output
fi

# check autojump
if which autojump &> /dev/null; then
	plugins+=autojump
fi

# check pip
if which pip &> /dev/null; then
	plugins+=pip
fi

# check pip
if which gem &> /dev/null; then
	plugins+=gem
fi

# start to install plugin
source $ZSH/oh-my-zsh.sh

################################################################################

# history setting
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPs
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

################################################################################
# language setting
LC_COLLATE="zh_TW.UTF-8"
LC_CTYPE="zh_TW.UTF-8"
LC_MONETARY="zh_TW.UTF-8"
LC_NUMERIC="zh_TW.UTF-8"
LC_TIME="zh_TW.UTF-8"
LC_MESSAGES="en_US.UTF-8"

export LC_COLLATE
export LC_CTYPE
export LC_MONETARY
export LC_NUMERIC
export LC_TIME
export LC_MESSAGES

################################################################################
# variable setting

# dropbox directory setup

if [ -d $HOME/Dropbox ]; then
	dbox=$HOME/Dropbox
fi

################################################################################
# alias
alias l="ls --color=always"	# ls is GNU ls not BSD ls
alias ll="ls -al --color=always"	# ls is GNU ls not BSD ls

if [ $OS = "Linux" ]; then
	alias pbcopy="xclip -i"
	alias pbpaste="xclip -o"
fi



################################################################################
# function

ccat() {

	if which source-highlight-esc.sh &> /dev/null; then
		source-highlight-esc.sh $1
	else
		echo "\x1b[31mcommand not found: source-highlight\x1b[0m" 1>&2
		cat $1
	fi
}

cless() {
	ccat $1 | less
}

################################################################################
# others
eval `dircolors ~/.dir_colors`

# colorize less for manpage
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# setup grep color & style
export GREP_COLOR='4;34' 

# setup less raw control
export LESS=" -R "

################################################################################
# start up

# auto attach/create tmux-session when ssh remote
if [ `which tmux` &> /dev/null ] && [ "$PS1" != "" ] && [ "$TMUX" = "" ] && [ "${SSH_TTY:-x}" != x ]; then
	sleep 1
	( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
	echo "tmux failed to start"
fi

# cowsay hello message

QUOTE="You can't connect the dots looking forward; you can only connect them looking backwards. So you have to trust that the dots will somehow connect in your future. You have to trust in something - your gut, destiny, life, karma, whatever. This approach has never let me down, and it has made all the difference in my life.\n\n - Steve Jobs"

if which lolcat &> /dev/null; then
	echo $QUOTE | cowsay | lolcat
else
	echo $QUOTE | cowsay
fi

if [ "$OS" = 'Linux' ]; then
	landscape-sysinfo
fi

################################################################################
# other
# Report CPU usage for each command
# REPORTTIME=0

