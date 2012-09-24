#! /bin/zsh
# Path of oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# theme name (theme in .oh-my-zsh/theme)
ZSH_THEME="powerline"

# setup plugin (plugin in .oh-my-zsh/plugin)
plugins=()

# check OS
OS=$(uname)
echo $OS

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

echo $plugins

# start to install plugin
source $ZSH/oh-my-zsh.sh

################################################################################
# Path setting

# path of macports
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export INFOPATH=/opt/local/share/info:$INFOPATH

# path of GNU coreutils
export PATH=/opt/local/libexec/gnubin:$PATH

# addd include path for C++
export CPLUS_INCLUDE_PATH=/opt/local/include

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




