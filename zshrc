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

# Custom prompt for pure.zsh
local PROMPT="%(?.%F{magenta}.%F{red}%?${PURE_PROMPT_SYMBOL:-❯}%F{magemta})${PURE_PROMPT_SYMBOL:-❯}%f "

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"
