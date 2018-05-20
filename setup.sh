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

# install fasd
if ! which fasd &> /dev/null; then
	# install fasd
	echo "Install \x1b[0;33mfasd\x1b[0m..."
	if [[ "$OS" = "Darwin" ]]; then
		brew install fasd
	else
		git clone --depth 1 https://github.com/catesandrew/fasd "$TMP_DIR/fasd"
		cd "$TMP_DIR/fasd"
		sudo make install
		cd "$SCRIPTPATH"
	fi
fi

# install fzf
if ! which fzf &> /dev/null; then
	# install fzf
	echo "Install \x1b[0;33mfzf\x1b[0m..."
	if [[ "$OS" = "Darwin" ]]; then
		brew install fzf
	else
		git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
		"$HOME/.fzf/install --no-update-rc"
	fi
fi

# remove existed zgen
remove_if_exists "$HOME/.zgen"

# download zgen
echo "Install \x1b[0;33mzgen\x1b[0m..."
git clone --depth 1 https://github.com/tarjoilija/zgen "$HOME/.zgen"

# install color scheme for gnome-terminal
if [[ "$OS" = "Linux" ]]; then
	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"
	URL="https://raw.githubusercontent.com/aaron-williamson/base16-gnome-terminal/master/color-scripts/base16-tomorrow-256.sh"
	THEME=$(basename "$URL")
	curl "$URL" -o "$TMP_DIR/$THEME"
	# import color scheme
	bash "$TMP_DIR/$THEME"
fi

ZSH_DIR="$HOME/.zsh"
# remove original .zsh directory
remove_if_exists "$ZSH_DIR"
# remove original .zshrc
remove_if_exists "$HOME/.zshrc"
# remove original .zshenv
remove_if_exists "$HOME/.zshenv"

ln -s "$SCRIPTPATH" "$ZSH_DIR"
ln -s "$ZSH_DIR/zshrc" "$HOME/.zshrc"
ln -s "$ZSH_DIR/zshenv" "$HOME/.zshenv"
source "$HOME/.zshrc"

# install color scheme for terminal on OS X
if [[ "$OS" = "Darwin" ]]; then
	echo "Install \x1b[0;33mTerminal Color Scheme\x1b[0m:"
	# import color scheme for OS X built-in terminal
	URL="https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night.terminal"
	THEME=$(basename "$URL")
	curl "$URL" -o "$TMP_DIR/$THEME"
	open "$TMP_DIR/$THEME"

	if [[ -d /Applications/iTerm.app ]]; then
		if [[ $(grep "base16-tomorrow" "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME") -ne "" ]]; then
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
