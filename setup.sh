#!/usr/bin/env zsh
#=============================================================================
#     FileName: install.sh
#         Desc: install my zsh setting
#       Author: KuoE0
#        Email: kuoe0.tw@gmail.com
#     HomePage: http://kuoe0.ch/
#      Version: 0.0.1
#   LastChange: 2012-09-24 22:53:29
#      History:
#=============================================================================

if [[ -n "${ITERM_PROFILE+x}" ]]; then
	echo "DO NOT setup in iTerm!"
	exit 1
fi

remove_if_exists() {
	TARGET="$1"
	if [[ -f "$TARGET" ]] || [[ -h "$TARGET" ]] || [[ -d "$TARGET" ]]; then
		rm -rf "$TARGET"
	fi
}

OS="$(uname)"
echo "Platform: \x1b[0;32m$OS\x1b[0m"

# absolute path of current directory
if [[ "$OS" = "Darwin" ]]; then
	TMP_DIR="/tmp/$(date +%s | md5 | head -c 10)"
	SCRIPTPATH=$(realpath "$0" | xargs -0 dirname)
	ITERM_PREF_NAME="com.googlecode.iterm2.plist"
	ITERM_PREF_LOCATION="$HOME/Library/Preferences"
else
	TMP_DIR="/tmp/$(date +%s | md5sum | head -c 10)"
	SCRIPTPATH=$(readlink -f "$0" | xargs -0 dirname)
fi

mkdir "$TMP_DIR"
echo "TMP Directory: \x1b[0;32m$TMP_DIR\x1b[0m"

# remove existed zgen
remove_if_exists "$HOME/.zgen"

# download zgen
echo "Install \x1b[0;33mzgen\x1b[0m..."
git clone --depth 1 https://github.com/tarjoilija/zgen "$HOME/.zgen"

if [[ "$OS" = "Linux" ]]; then
	echo "Install \x1b[0;33mautoenv\x1b[0m..."
	# remove existed autoenv
	remove_if_exists "$HOME/.autoenv"
	git clone --depth 1 https://github.com/kennethreitz/autoenv "$HOME/.autoenv"
	# install fasd on Linux
	echo "Install \x1b[0;33mfasd\x1b[0m..."
	git clone --depth 1 https://github.com/catesandrew/fasd "$TMP_DIR/fasd"
	cd "$TMP_DIR/fasd"
	sudo make install
	cd "$SCRIPTPATH"
fi

# install solarized color scheme for gnome-terminal
if [[ "$OS" = "Linux" ]]; then
	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"
	git clone --depth 1 https://github.com/sigurdga/gnome-terminal-colors-solarized.git "$TMP_DIR/gnome-terminal-colors-solarized"
	# import color scheme
	"$TMP_DIR/gnome-terminal-colors-solarized/set_dark.sh"
fi

# install color scheme for terminal on OS X
if [[ "$OS" = "Darwin" ]]; then
	echo "Install \x1b[0;33mTerminal Color Scheme\x1b[0m:"
	# import color scheme for OS X built-in terminal
	open Solarized-Dark-xterm-256color.terminal
	URL="https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night.terminal"
	THEME=$(basename "$URL")
	curl "$URL" -o "$TMP_DIR/$THEME"
	open "$TMP_DIR/$THEME"

	if [[ -d /Applications/iTerm.app ]]; then
		if [[ $(grep Solarized "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME") -ne "" ]]; then
			# import color scheme iTerm2
			URL="https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-tomorrow.dark.256.itermcolors"
			THEME=$(basename "$URL")
			curl "$URL" -o "$TMP_DIR/$THEME"
			open "$TMP_DIR/$THEME"
		fi
	fi
fi

ZSH_DIR="$HOME/.zsh"
# remove original .zsh directory
remove_if_exists "$ZSH_DIR"
# remove original .zshrc
remove_if_exists "$HOME/.zshrc"

ln -s "$SCRIPTPATH" "$ZSH_DIR"
ln -s "$ZSH_DIR/zshrc" "$HOME/.zshrc"
source "$HOME/.zshrc"

# iTerm2 preference
if [[ -d /Applications/iTerm.app ]]; then
	killall iTerm
	if [[ -f "$ITERM_PREF_LOCATION/$ITERM_PREF" ]]; then
		defaults delete com.googlecode.iterm2
	fi
	cp "$SCRIPTPATH/$ITERM_PREF_NAME" "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME"
	defaults read -app iTerm
fi
