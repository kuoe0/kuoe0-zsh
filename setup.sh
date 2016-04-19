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

if [ -n "${ITERM_PROFILE+x}" ]; then
	echo "DO NOT setup in iTerm!"
	exit 1
fi

OS=$(uname)
echo "Platform: \x1b[0;32m$OS\x1b[0m"

# absolute path of current directory
if [ "$OS" = "Darwin" ]; then
	TMP_DIR="/tmp/$(date +%s | md5 | head -c 10)"
	SCRIPTPATH=$(realpath $0 | xargs dirname)
	ITERM_PREF_NAME="com.googlecode.iterm2.plist"
	ITERM_PREF_LOCATION="$HOME/Library/Preferences"
else
	TMP_DIR="/tmp/$(date +%s | md5sum | head -c 10)"
	SCRIPTPATH=$(readlink -f $0 | xargs dirname)
fi

ZSH_DIR="$HOME/.zsh"

mkdir $TMP_DIR
echo "TMP Directory: \x1b[0;32m$TMP_DIR\x1b[0m"

# remove origin .oh-my-zsh
if [ -f $HOME/.oh-my-zsh ] || [ -h $HOME/.oh-my-zsh ] || [ -d $HOME/.oh-my-zsh ]; then
	rm -rf $HOME/.oh-my-zsh
fi

# remove origin dircolors
if [ -f $HOME/.dir_colors ]; then
	rm $HOME/.dir_colors
fi

if [ -f $HOME/.function.zsh ] || [ -h $HOME/.function.zsh ]; then
	rm $HOME/.function.zsh
fi

# download oh-my-zsh
echo "Install \x1b[0;33moh-my-zsh\x1b[0m..."
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# download oh-my-zsh-solarized-powerline-theme
echo "Install \x1b[0;33moh-my-zsh-solarized-powerline-theme\x1b[0m..."
URL="https://raw.githubusercontent.com/KuoE0/oh-my-zsh-solarized-powerline-theme/master/solarized-powerline.zsh-theme"
curl $URL -o $HOME/.oh-my-zsh/themes/solarized-powerline.zsh-theme

# download zsh-autosuggesions
echo "Install \x1b[0;33mzsh-autosuggestions\x1b[0m..."
git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# install solarized color scheme for dircolors
echo "Install \x1b[0;33mdircolors-solarized\x1b[0m..."
URL="https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark"
curl $URL -o $HOME/.dir_colors

# install fasd on Linux
if [ "$OS" = "Linux" ]; then
	echo "Install \x1b[0;33mfasd\x1b[0m..."
	git clone --depth 1 https://github.com/catesandrew/fasd $TMP_DIR/fasd
	cd $TMP_DIR/fasd
	sudo make install
	cd $SCRIPTPATH
fi

# install solarized color scheme for gnome-terminal
if [ "$OS" = "Linux" ]; then
	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"
	git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git $TMP_DIR/gnome-terminal-colors-solarized
	# import color scheme
	$TMP_DIR/gnome-terminal-colors-solarized/set_dark.sh
fi

# install solarized color scheme for terminal on OS X
if [ "$OS" = "Darwin" ]; then
	echo "Install \x1b[0;33mTerminal Color Scheme\x1b[0m:"
	# import color scheme for OS X built-in terminal
	open Solarized-Dark-xterm-256color.terminal
	if [ -d /Applications/iTerm.app ]; then
		if [ $(grep Solarized "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME") -ne "" ]; then
			# import color scheme iTerm2
			URL="https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors"
			curl $URL -o "$TMP_DIR/Solarized Dark.itermcolors"
			open "$TMP_DIR/Solarized Dark.itermcolors"
		fi
	fi
fi

# font installation
if [ "$OS" = "Darwin" ]; then
	# Monaco Powerline Patch
	cp $SCRIPTPATH/Monaco-Powerline-OSX.otf ~/Library/Fonts/
	# Inconsolata
	cp $SCRIPTPATH/Inconsolata.otf ~/Library/Fonts/
	# Inconsolata Nerd Font Patch (https://github.com/ryanoasis/nerd-fonts)
	cp $SCRIPTPATH/Inconsolata-for-Powerline-Nerd-Font-Complete.otf ~/Library/Fonts/
	cp $SCRIPTPATH/Inconsolata-for-Powerline-Nerd-Font-Complete-Mono.otf ~/Library/Fonts/
elif [ "$OS" = "Linux" ]; then
	mkdir -p ~/.local/share/fonts
	# Inconsolata
	cp $SCRIPTPATH/Inconsolata.otf ~/.local/share/fonts
	# Inconsolata Nerd Font Patch (https://github.com/ryanoasis/nerd-fonts)
	cp $SCRIPTPATH/Inconsolata-for-Powerline-Nerd-Font-Complete.otf ~/.local/share/fonts
	cp $SCRIPTPATH/Inconsolata-for-Powerline-Nerd-Font-Complete-Mono.otf ~/.local/share/fonts
	# Update font cache
	fc-cache -fv
fi

# instal fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo '\n\n' | ~/.fzf/install

# remove original .zsh directory
if [ -d $ZSH_DIR ] || [ -f $ZSH_DIR ] || [ -h $ZSH_DIR ]; then
	rm $ZSH_DIR
fi

# remove original .zshrc 
if [ -f $HOME/.zshrc ] || [ -h $HOME/.zshrc ]; then
	rm $HOME/.zshrc
fi

ln -s $SCRIPTPATH $ZSH_DIR
ln -s $ZSH_DIR/zshrc $HOME/.zshrc
source $HOME/.zshrc

# iTerm2 preference
if [ -d /Applications/iTerm.app ]; then
	killall iTerm
	if [ -f "$ITERM_PREF_LOCATION/$ITERM_PREF" ]; then
		defaults delete com.googlecode.iterm2
	fi
	cp "$SCRIPTPATH/$ITERM_PREF_NAME" "$ITERM_PREF_LOCATION/$ITERM_PREF_NAME"
	defaults read -app iTerm
fi
