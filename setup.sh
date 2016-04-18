#! /bin/zsh
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

OS=$(uname)
echo "Platform: \x1b[0;32m$OS\x1b[0m"

CD_DIR=$(dirname $0)
# absolute path of current directory
SCRIPTPATH=`cd $CD_DIR; pwd`
if [ "$OS" = "Darwin" ]; then
	TMP_DIR="/tmp/$(date +%s | md5 | head -c 10)"
else
	TMP_DIR="/tmp/$(date +%s | md5sum | head -c 10)"
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

# install solarized color scheme for dircolors
echo "Install \x1b[0;33mdircolors-solarized\x1b[0m..."
URL="https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark"
curl $URL -o $HOME/.dir_colors

# install fasd on Linux
if [ "$OS" = "Linux" ]; then
	echo "Install \x1b[0;33mfasd\x1b[0m..."
	wget -O $TMP_DIR/fasd-1.0.1.tar.gz https://github.com/clvv/fasd/archive/1.0.1.tar.gz
	tar -zxf $TMP_DIR/fasd-1.0.1.tar.gz -C $TMP_DIR
	cd $TMP_DIR/fasd-1.0.1
	sudo make install
	# eval $(fasd --init auto)
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
		# import color scheme iTerm2
		URL="https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors"
		curl $URL -o "$TMP_DIR/Solarized Dark.itermcolors"
		open "$TMP_DIR/Solarized Dark.itermcolors"
	fi
fi

# font installation
if [ "$OS" = "Darwin" ]; then
	# Monaco Powerline Patch
	cp Monaco-Powerline-OSX.otf ~/Library/Fonts/
	# Inconsolata
	cp Inconsolata.otf ~/Library/Fonts/
	# Inconsolata Nerd Font Patch (https://github.com/ryanoasis/nerd-fonts)
	cp Inconsolata-for-Powerline-Nerd-Font-Complete.otf ~/Library/Fonts/
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
	ITERM_PREF="$USER/Library/Preferences/com.googlecode.iterm2.plist"
	if [ -f $ITERM_PREF ]; then
		defaults delete com.googlecode.iterm2
	fi
	cp "$(basename $ITERM_PREF)" "$ITERM_PREF"
	defaults read -app iTerm
fi
