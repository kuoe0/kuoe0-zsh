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
export PATH="/sbin:/usr/sbin:$PATH"
# Path config for Mac OS X
if [ "$OS" = 'Darwin' ]; then
	# use package of homebrew
	export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
	# path of GNU coreutils
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	# path of GNU tar
	export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

	# man page for GNU coreutils
	export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

	# let pkg-config find libxml-2.0 libxslt libexslt libcurl
	export PKG_CONFIG_PATH=/usr/local/Library/ENV/pkgconfig/10.8

	# environment variable of include directory for gnu tool
	export C_INCLUDE_PATH=/usr/local/include
	export CPLUS_INCLUDE_PATH=/usr/local/include

	# environment variable of library directory for gnu tool
	LIBRARY_PATH=/usr/local/lib
fi

# access the online help
export HELPDIR=/usr/local/share/zsh/helpfiles

################################################################################
# Path of oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# theme name (theme in .oh-my-zsh/theme)
ZSH_THEME="solarized-powerline"
# solarized-powerline theme variable
export ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY=true

# setup plugin (plugin in .oh-my-zsh/plugin)
plugins=(copydir copyfile history history-substring-search web-search urltools)

if [ "$OS" = 'Linux' ]; then	# Linux
	plugins+=command-not-found
elif [ "$OS" = 'Darwin' ]; then		# Mac OS X
	plugins+=osx
	# check homebrew
	if which brew &> /dev/null; then
		plugins+=brew
	fi

	# check homebrew cask
	if which brew-cask &> /dev/null; then
		plugins+=brew-cask
		export HOMEBREW_CASK_OPTS="--appdir=/Applications"
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
	git config --global core.editor `which vim` # let git use the correct vim on Mac
	git config --global color.ui auto			# colorize git output
	git config --global push.default simple
	git config --global branch.autosetuprebase always
	git config --global alias.check checkout
	git config --global alias.moz-patch "format-patch -U8 -kp --stdout" # Mozilla style patch
	git config --global alias.unstage "reset HEAD --"
	git config --global alias.discard "checkout -- ." # checkout all modified files
	git config --global alias.cleanup "clean -df"
	git config --global alias.last 'log -1 HEAD'
fi

# check git-flow
if which git-flow &> /dev/null; then
	plugins+=git-flow
fi

# check fasd
if which fasd &> /dev/null; then
	plugins+=fasd
fi

# check pip
if which pip &> /dev/null; then
	plugins+=pip
fi

# check gem
if which gem &> /dev/null; then
	plugins+=gem
fi

# check bower
if which bower &> /dev/null; then
	plugins+=bower
fi

# check mosh
if which mosh &> /dev/null; then
	plugins+=mosh
fi

# check npm
if which npm &> /dev/null; then
	plugins+=npm
fi

# start to install plugin
source $ZSH/oh-my-zsh.sh

################################################################################
# environment variable settings

# default editor
export EDITOR=vim

# language setting
export LC_COLLATE="zh_TW.UTF-8"
export LC_CTYPE="zh_TW.UTF-8"
export LC_MONETARY="zh_TW.UTF-8"
export LC_NUMERIC="zh_TW.UTF-8"
export LC_TIME="zh_TW.UTF-8"
export LC_MESSAGES="zh_TW.UTF-8"
export LANG="zh_TW.UTF-8"
export LC_ALL="zh_TW.UTF-8"


################################################################################
# history setting

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPs
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

################################################################################
# variable setting

# dropbox directory setup

if [ -d $HOME/Dropbox ]; then
	dbox=$HOME/Dropbox
fi

################################################################################
# alias
alias l="ls --color=always"			# ls is GNU ls not BSD ls
alias ll="ls -al --color=always"	# ls is GNU ls not BSD ls
alias llh="ls -alh --color=always"	# ls is GNU ls not BSD ls
alias cgrep="grep --color=always" 
alias getip="curl -s http://ipecho.net/plain || echo -n 'no internet connection' ; echo"

# usually typo
alias ivm="vim"
alias k="l"

if [ $OS = "Linux" ]; then
	alias pbcopy="xclip -i"
	alias pbpaste="xclip -o"
fi

# access the online help
unalias run-help &> /dev/null
autoload run-help

################################################################################
# fzf (https://github.com/junegunn/fzf)
################################################################################
# Ctrl-T: file search
# Ctrl-R: recent command search
# Option-C: directory search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# enable extended mode
export FZF_DEFAULT_OPTS='--extended'

################################################################################
# colourify settings
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
export GREP_COLOR='4;32' 

# raw control (-R), highlight search (-g), merge consecutive blank line (-s)
export LESS="-RMgs"

# auto use grc (Generic Colouriser) to process content
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
then
    alias colourify="$GRC -es --colour=on"
    alias configure='colourify ./configure'
    alias diff='colourify diff -u'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
fi

# use colordiff to replace diff
if [ -n "$(which colordiff)" ]; then
	alias diff='colordiff -u'
fi


# function load
source $HOME/.zsh/function.zsh

################################################################################
# start up

if [ `which tmux` &> /dev/null ]; then
	if [ "${SSH_TTY:-x}" != x ] && [ "$TMUX" = "" ]; then
		ret=""
		while [ "$ret" != "y" ] && [ "$ret" != "n" ]; do
			read -t 30 ret\?"Launch tmux? [Y/n] "
			if [ "$ret" = "" ]; then
				ret="y"
			fi
		done

		# attach remote session when ssh login
		if [ "$ret" = "y" ]; then
			( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
		fi
		unset $ret &> /dev/null
	fi
fi

PADDING=$((($(tput cols) - 70 + 1) / 2))

WELCOME="
   __ __          _______   Don't run after success.
  / //_/_ _____  / __/ _ \\  Be excellent, success will run after you.
 / .< / // / _ \\/ _// // /
/_/|_|\\___/\\___/___/\\___/                                   - 3 Idiot

        System load:        $(cpu_load)        Memory usage:    $(memory_usage) %
        Uptime:             $(machine_uptime)"

for i in $(seq 1 $PADDING);
do
	WELCOME=$(echo $WELCOME | sed "s/^/ /")
done

if ! which lolcat &> /dev/null; then
	alias lolcat=cat
fi

echo $WELCOME | lolcat

unalias lolcat &> /dev/null

################################################################################
# Other
################################################################################

# Report CPU usage for each command
REPORTTIME=10
# Github API token for homebrew
export HOMEBREW_GITHUB_API_TOKEN=c68984b4b136f75b57644e87fec8e8661d29f84e
