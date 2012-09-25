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
#! /bin/zsh

################################################################################
# get OS name
OS=$(uname)
################################################################################
# Path setting

# path of GNU coreutils
if [ "$OS" = 'Darwin' ]; then
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
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
# history key binding
bindkey ^f  history-incremental-search-backward

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
alias gitst="git status"
alias l="ls --color=auto"	# ls is GNU ls not BSD ls
alias ll="ls -al --color=auto"	# ls is GNU ls not BSD ls


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


################################################################################
# start up

# cowsay hello message
fortune | cowsay | lolcat
