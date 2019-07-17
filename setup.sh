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

###
# Basic Setup for Installation
###

remove_if_exists() {
	TARGET="$1"
	if [[ -f "$TARGET" ]] || [[ -h "$TARGET" ]] || [[ -d "$TARGET" ]]; then
		rm -rf "$TARGET"
	fi
}

OS="$(uname)"
echo "Platform: \x1b[0;32m$OS\x1b[0m"

# absolute path of current directory
if [ "$OS" = "Darwin" ]; then
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

###
# Install Prerequisite Packages
###

PKG_LIST=(fasd fzf)
for PKG in $PKG_LIST; do
	if ! which $PKG &> /dev/null; then
		echo "Install \x1b[0;33m$PKG\x1b[0m..."
		brew install $PKG
	fi
done

###
# Install zplug (plugin manager for zsh)
###

# remove existed zplug
remove_if_exists "$HOME/.zplug"

# download zplug
echo "Install \x1b[0;33mzplug\x1b[0m..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

###
# Setup Profile Location
###

ZSH_DIR="$HOME/.zsh"
# remove original .zsh directory
remove_if_exists "$ZSH_DIR"
# remove original .zshrc
remove_if_exists "$HOME/.zshrc"
# remove original .zshenv
remove_if_exists "$HOME/.zshenv"

ln -s "$SCRIPTPATH" "$ZSH_DIR"
ln -s "$SCRIPTPATH/zshrc" "$HOME/.zshrc"
ln -s "$SCRIPTPATH/zshenv" "$HOME/.zshenv"

###
# Install Color scheme
###

# install color scheme for gnome-terminal
if [ "$OS" = "Linux" ]; then
	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"
	URL="https://raw.githubusercontent.com/aaron-williamson/base16-gnome-terminal/master/color-scripts/base16-tomorrow-256.sh"
	THEME=$(basename "$URL")
	curl "$URL" -o "$TMP_DIR/$THEME"
	# import color scheme
	bash "$TMP_DIR/$THEME"
fi

# install color scheme for terminal on OS X
if [ "$OS" = "Darwin" ]; then
	echo "Install \x1b[0;33mTerminal Color Scheme\x1b[0m:"
	# import color scheme for OS X built-in terminal
	URL="https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night.terminal"
	THEME=$(basename "$URL")
	curl "$URL" -o "$TMP_DIR/$THEME"
	open "$TMP_DIR/$THEME"

	if [ -d /Applications/iTerm.app ]; then
		grep "base16-tomorrow" "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME" > /dev/null
		if [ "$?" != "0" ]; then
			# import color scheme iTerm2
			URL="https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-tomorrow.dark.256.itermcolors"
			THEME=$(basename "$URL")
			curl "$URL" -o "$TMP_DIR/$THEME"
			open "$TMP_DIR/$THEME"
		fi
	fi
fi

# iTerm2 preference
if [[ -d /Applications/iTerm.app ]]; then
	killall iTerm
	if [[ -f "$ITERM_PREF_LOCATION/$ITERM_PREF" ]]; then
		defaults delete com.googlecode.iterm2
	fi
	yes | cp "$SCRIPTPATH/$ITERM_PREF_NAME" "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME"
	defaults read -app iTerm
fi

source "$HOME/.zshenv"
source "$HOME/.zshrc"
