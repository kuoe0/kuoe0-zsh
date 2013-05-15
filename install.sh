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
echo "Platform: $OS"

CD_DIR=$(dirname $0)
# absolute path of current directory
SCRIPTPATH=`cd $CD_DIR; pwd`

echo $SCRIPTPATH

# remove orgin .oh-my-zsh
if [ -f ~/.oh-my-zsh ] || [ -h ~/.oh-my-zsh ] || [ -d ~/.oh-my-zsh ]; then
	rm -rf ~/.oh-my-zsh
fi

# remove orgin .powerline-oh-my-zsh-theme
if [ -f ~/.powerline-oh-my-zsh-theme ] || [ -h ~/.powerline-oh-my-zsh-theme ] || [ -d ~/.powerline-oh-my-zsh-theme ]; then
	rm -rf ~/.powerline-oh-my-zsh-theme
fi

# remove orgin .zshrc and relink
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
	rm ~/.zshrc
fi

ln -s $SCRIPTPATH/zshrc ~/.zshrc

# download oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# download powerline-theme
git clone git://github.com/KuoE0/Powerline-oh-my-zsh-theme.git ~/.powerline-oh-my-zsh-theme

# install solarized  color scheme for dircolors
if [ "$OS" != "FreeBSD" ]; then
	# download dircolors-solarized
	git clone git://github.com/seebi/dircolors-solarized.git /tmp/dircolors-solarized
	# copy color scheme to ~/.dir_colors
	if [ -f ~/.dir_colors ]; then
		rm ~/.dir_colors
	fi
	cp /tmp/dircolors-solarized/dircolors.256dark ~/.dir_colors
fi

# install solarized color scheme for gnome-terminal
if [ "$OS" = "Linux" ]; then
	echo "setting solarized color scheme..."
	# download color scheme
	git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git /tmp/gnome-terminal-colors-solarized
	# set color scheme
	/tmp/gnome-terminal-colors-solarized/set_dark.sh
fi


# link theme to oh-my-zsh
ln -s ~/.powerline-oh-my-zsh-theme/powerline.zsh-theme ~/.oh-my-zsh/themes/
source ~/.zshrc

