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
TMP_DIR="/tmp/$(date +%s | md5sum | head -c 10)"
mkdir $TMP_DIR
echo "TMP Directory: \x1b[0;32m$TMP_DIR\x1b[0m"

# remove orgin .oh-my-zsh
if [ -f ~/.oh-my-zsh ] || [ -h ~/.oh-my-zsh ] || [ -d ~/.oh-my-zsh ]; then
	rm -rf ~/.oh-my-zsh
fi

# remove orgin .oh-my-zsh-solarized-powerline-theme
if [ -f ~/.oh-my-zsh-solarized-powerline-theme ] || [ -h ~/.oh-my-zsh-solarized-powerline-theme ] || [ -d ~/.oh-my-zsh-solarized-powerline-theme ] ; then
	rm -rf ~/.oh-my-zsh-solarized-powerline-theme
fi

# remove orgin .zshrc and relink
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
	rm ~/.zshrc
fi

ln -s $SCRIPTPATH/zshrc ~/.zshrc

# download oh-my-zsh
echo "Download \x1b[0;33moh-my-zsh\x1b[0m..."
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh | sed "s/^/    /"

# download oh-my-zsh-solarized-powerline-theme
echo "Download \x1b[0;33moh-my-zsh-solarized-powerline-theme\x1b[0m..."
git clone https://github.com/KuoE0/oh-my-zsh-solarized-powerline-theme.git ~/.oh-my-zsh-solarized-powerline-theme | sed "s/^/    /"

# link theme to oh-my-zsh
ln -s ~/.oh-my-zsh-solarized-powerline-theme/solarized-powerline.zsh-theme ~/.oh-my-zsh/themes/

# install solarized color scheme for dircolors
if [ "$OS" != "FreeBSD" ]; then
	# download dircolors-solarized
	echo "Download \x1b[0;33mdircolors-solarized\x1b[0m..."
	git clone https://github.com/seebi/dircolors-solarized.git $TMP_DIR/dircolors-solarized | sed "s/^/    /"
	# copy color scheme to ~/.dir_colors
	if [ -f ~/.dir_colors ]; then
		rm ~/.dir_colors
	fi
	cp $TMP_DIR/dircolors-solarized/dircolors.256dark ~/.dir_colors
fi

# install solarized color scheme for gnome-terminal
if [ "$OS" = "Linux" ]; then
	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"
	# for gnome-terminal
	echo "Download \x1b[0;33mgnome-terminal-colors-solarized\x1b[0m..."
	git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git $TMP_DIR/gnome-terminal-colors-solarized | sed "s/^/    /"
	# import color scheme
	$TMP_DIR/gnome-terminal-colors-solarized/set_dark.sh
fi

# install solarized color scheme for terminal on OS X
if [ "$OS" = "Darwin" ]; then

	echo "Install \x1b[0;34mTerminal Color Scheme\x1b[0m:"

	# import color scheme for OS X built-in terminal
	open Solarized\ Dark\ xterm-256color.terminal

	if [ -d /Applications/iTerm.app ]; then

		# import color scheme iTerm2
		echo "Download \x1b[0;33msolarized\x1b[0m..."
		git clone https://github.com/altercation/solarized.git $TMP_DIR/solarized | sed "s/^/    /"
		open $TMP_DIR/solarized/iterm2-colors-solarized/Solarized\ Dark.itermcolors
	fi
fi
	
source ~/.zshrc

