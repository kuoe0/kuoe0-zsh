#=============================================================================
#     FileName: zshrc
#       Author: KuoE0
#        Email: kuoe0.tw@gmail.com
#=============================================================================
export OS=$(uname)

# zgen start
source "$HOME/.zgen/zgen.zsh"

if ! zgen saved; then
	export ZGEN_PREZTO_LOAD_DEFAULT=0 # *DON'T* load default prezto setting
	source "$HOME/.zsh/plugin-list.zsh"
	# save all to init script
	zgen save
fi
# zgen end

# --- Environment Variables ---
# BASE16_SUPPORT default is 0, except it is already set. (e.g. SendEnv / AcceptEnv in ssh)
export BASE16_SUPPORT=${BASE16_SUPPORT:-0}
# iTerm support 256 color space to use base 16
if [[ "$TERM_PROGRAM" = "iTerm.app" ]]; then
	export BASE16_SUPPORT=1
fi

# vim colorscheme
export VIM_COLORSCHEME="Tomorrow-Night"
export VIM_AIRLINE_THEME="tomorrow"
if [[ "$BASE16_SUPPORT" = "1" ]]; then
	export VIM_COLORSCHEME="base16-tomorrow"
	export VIM_AIRLINE_THEME="base16"
fi

# Custom prompt for pure.zsh
local PROMPT="%(?.%F{magenta}.%F{red}%?${PURE_PROMPT_SYMBOL:-❯}%F{magemta})${PURE_PROMPT_SYMBOL:-❯}%f "

################################################################################
# Path setting
export PATH="$HOME/Dropbox/Works/scripts:/sbin:/usr/sbin:$PATH"
# Path config for Mac OS X
if [ "$OS" = 'Darwin' ]; then
	# use package of homebrew
	export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

	# let pkg-config find libxml-2.0 libxslt libexslt libcurl
	export PKG_CONFIG_PATH=/usr/local/Library/ENV/pkgconfig/10.8

	# environment variable of include directory for gnu tool
	export C_INCLUDE_PATH=/usr/local/include
	export CPLUS_INCLUDE_PATH=/usr/local/include

	if [ -d "/usr/local/opt/llvm" ]; then
		export PATH="/usr/local/opt/llvm/bin:$PATH"
	fi

	# environment variable of library directory for gnu tool
	LIBRARY_PATH=/usr/local/lib
fi

# access the online help
export HELPDIR=/usr/local/share/zsh/helpfiles

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
# dropbox directory setup

if [ -d $HOME/Dropbox ]; then
	dbox=$HOME/Dropbox
fi

################################################################################
# clear alias
which myip 2>/dev/null 1>/dev/null && unalias myip
which rm   2>/dev/null 1>/dev/null && unalias rm
which z    2>/dev/null 1>/dev/null && unalias z

# alias
alias myip="curl -s http://ipecho.net/plain || echo -n 'no internet connection' ; echo"
alias rm='nocorrect rm -I'
alias z="fasd_cd"
which nvim 2>/dev/null 1>/dev/null && alias vim="nvim"

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
# enable extended mode
export FZF_DEFAULT_OPTS='--extended'
if [ $OS = "Linux" ]; then
	source "$HOME/.fzf.zsh"
	source "$HOME/.fzf/shell/key-bindings.zsh"
else
	source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

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
	alias grc="nocorrect grc"
	alias colourify="grc -es --colour=on"
	alias configure='colourify ./configure'
	alias netstat='colourify netstat'
	alias ping='colourify ping'
	alias traceroute='colourify /usr/sbin/traceroute'
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
# Ruby Programming Language
################################################################################
if command -v rbenv &> /dev/null; then
	eval "$(rbenv init -)"
fi

################################################################################
# Other
################################################################################
# Report CPU usage for each command
REPORTTIME=10
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"
eval "$(thefuck --alias)"
