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
export OS=$(uname | tr '[:upper:]' '[:lower:]')
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# zgen start
source $HOME/.zgen/zgen.zsh

if ! zgen saved; then
	zgen oh-my-zsh
	source $HOME/.zsh/plugin-list.zsh
	# save all to init script
	zgen save
fi

# zgen end

################################################################################
# Path setting
export PATH="/sbin:/usr/sbin:$PATH"
# Path config for Mac OS X
if [ "$OS" = 'darwin' ]; then
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
# Git configuration
if command -v git &> /dev/null; then
	git config --global user.name "KuoE0"
	git config --global user.email "kuoe0.tw@gmail.com"
	git config --global core.editor `command -v vim` # let git use the correct vim on Mac
	git config --global color.ui auto # colorize git output
	git config --global push.default simple
	git config --global branch.autosetuprebase always
	git config --global alias.check checkout
	git config --global alias.moz-patch "format-patch -U8 -kp --stdout -1" # Mozilla style patch
	git config --global alias.unstage "reset HEAD --"
	git config --global alias.discard "checkout -- ." # checkout all modified files
	git config --global alias.cleanup "clean -df"
	git config --global alias.last 'log -1 HEAD'
	git config --global alias.ls-conflict "diff --name-only --diff-filter=U"
fi
################################################################################
# environment variable settings
# default editor
export EDITOR=vim
# base16 support or not
export BASE16_SUPPORT=${BASE16_SUPPORT:-0}
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
	export BASE16_SUPPORT=1
fi
# vim colorscheme
export VIM_COLORSCHEME="base16-tomorrow"

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
alias gdiff="git diff"

# usually typo
alias ivm="vim"
alias k="l"

if [ $OS = "linux" ]; then
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
if [ "$TERM" != dumb ] && command -v grc &> /dev/null; then
    alias colourify="grc -es --colour=on"
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
if command -v colordiff &> /dev/null; then
	alias diff='colordiff -u'
fi

# function load
source $HOME/.zsh/function.zsh

################################################################################
# start up
################################################################################

if command -v tmux &> /dev/null; then
	if [ "${SSH_TTY:-x}" != x ] && [ "$TMUX" = "" ]; then
		ret=""
		while [ "$ret" != "y" ] && [ "$ret" != "n" ]; do
			read -t 30 ret\?"Launch tmux? [Y/n] "
			ret=$(echo $ret | tr '[:upper:]' '[:lower:]')
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

################################################################################
# Other
################################################################################
# Report CPU usage for each command
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline" # underline
