export OS=$(uname)
export KUOE0_ZSH="$HOME/.zsh"

export PATH="$HOME/Dropbox/Works/scripts:/sbin:/usr/sbin:$PATH"

if [ "$OS" = 'Darwin' ]; then
	export HOMEBREW="/usr/local/bin/brew"
else
	export HOMEBREW="$(linuxbrew --prefix)/bin/brew"
fi
export HOMEBREW_PREFIX=$($HOMEBREW --prefix)
export HOMEBREW_NO_AUTO_UPDATE=1

if [ -d "$HOMEBREW_PREFIX" ]; then
	# use package of homebrew
	export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

	# environment variable of library directory for gnu tool
	export LIBRARY_PATH="$HOMEBREW_PREFIX/lib"
	export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"

	# environment variable of include directory for gnu tool
	export C_INCLUDE_PATH="$HOMEBREW_PREFIX/include"
	export CPLUS_INCLUDE_PATH="$HOMEBREW_PREFIX/include"

	if [ -d "$HOMEBREW_PREFIX/opt/llvm" ]; then
		export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
	fi

	if [ "$OS" = 'Darwin' ]; then
		# use coreutils with prefix
		export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
		export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

		# access the online help
		export HELPDIR="$HOMEBREW_PREFIX/share/zsh/helpfiles"
	fi

	# source completion functions
	if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]; then
		fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
	fi

	# need to install `zsh-completions`
	if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]; then
		fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
	fi
fi

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
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Report CPU usage for each command
export REPORTTIME=10
