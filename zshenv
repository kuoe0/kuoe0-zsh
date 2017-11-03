export PATH="$HOME/Dropbox/Works/scripts:/sbin:/usr/sbin:$PATH"

# Path config for Mac OS X
if [ "$OS" = 'Darwin' ]; then
	# use package of homebrew
	export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
	# use coreutils with prefix
	export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	# let pkg-config find libxml-2.0 libxslt libexslt libcurl
	export PKG_CONFIG_PATH=/usr/local/Library/ENV/pkgconfig/10.8

	# environment variable of include directory for gnu tool
	export C_INCLUDE_PATH=/usr/local/include
	export CPLUS_INCLUDE_PATH=/usr/local/include

	if [ -d "/usr/local/opt/llvm" ]; then
		export PATH="/usr/local/opt/llvm/bin:$PATH"
	fi

	# environment variable of library directory for gnu tool
	export LIBRARY_PATH=/usr/local/lib
	export MANPATH=/usr/local/share/man:$MANPATH
	export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

# access the online help
export HELPDIR=/usr/local/share/zsh/helpfiles

# default editor
export EDITOR=vim

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

# language setting
export LC_COLLATE="zh_TW.UTF-8"
export LC_CTYPE="zh_TW.UTF-8"
export LC_MONETARY="zh_TW.UTF-8"
export LC_NUMERIC="zh_TW.UTF-8"
export LC_TIME="zh_TW.UTF-8"
export LC_MESSAGES="zh_TW.UTF-8"
export LANG="zh_TW.UTF-8"
export LC_ALL="zh_TW.UTF-8"

# Report CPU usage for each command
export REPORTTIME=10
