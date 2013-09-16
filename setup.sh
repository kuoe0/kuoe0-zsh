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

# remove origin .oh-my-zsh
if [ -f $HOME/.oh-my-zsh ] || [ -h $HOME/.oh-my-zsh ] || [ -d $HOME/.oh-my-zsh ]; then
	rm -rf $HOME/.oh-my-zsh
fi

# remove origin .oh-my-zsh-solarized-powerline-theme
if [ -f $HOME/.oh-my-zsh-solarized-powerline-theme ] || [ -h $HOME/.oh-my-zsh-solarized-powerline-theme ] || [ -d $HOME/.oh-my-zsh-solarized-powerline-theme ] ; then
	rm -rf $HOME/.oh-my-zsh-solarized-powerline-theme
fi
# remove origin dircolors
if [ -f $HOME/.dir_colors ]; then
	rm $HOME/.dir_colors
fi
# remove origin .zshrc and relink
if [ -f $HOME/.zshrc ] || [ -h $HOME/.zshrc ]; then
	rm $HOME/.zshrc
fi

if [ -f $HOME/.function.zsh ] || [ -h $HOME/.function.zsh ]; then
	rm $HOME/.function.zsh
fi


# download oh-my-zsh
echo "Install \x1b[0;33moh-my-zsh\x1b[0m..."
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# download oh-my-zsh-solarized-powerline-theme
echo "Install \x1b[0;33moh-my-zsh-solarized-powerline-theme\x1b[0m..."
URL="https://raw.github.com/KuoE0/oh-my-zsh-solarized-powerline-theme/master/solarized-powerline.zsh-theme"
curl $URL -o $HOME/.oh-my-zsh/themes/solarized-powerline.zsh-theme

# install solarized color scheme for dircolors
echo "Install \x1b[0;33mdircolors-solarized\x1b[0m..."
URL="https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark"
curl $URL -o $HOME/.dir_colors

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
		URL="https://raw.github.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors"
		curl $URL -o "$TMP_DIR/Solarized Dark.itermcolors"
		open "$TMP_DIR/Solarized Dark.itermcolors"
	fi
fi

if [ "$OS" = "Darwin" ]; then
	curl https://gist.github.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco+for+Powerline.otf -o /tmp/Monaco-Powerline-OSX.otf
	mv /tmp/Monaco-Powerline-OSX.otf ~/Library/Fonts/
fi

ln -s $SCRIPTPATH/zshrc $HOME/.zshrc
ln -s $SCRIPTPATH/function.zsh $HOME/.function.zsh
source $HOME/.zshrc

