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
echo $OS

# setting readlink command
if [ "$OS" = 'Linux' ]; then
	READLINK='readlink'
elif [ "$OS" = 'Darwin' ]; then
	# need GNU Coreutils; sudo port install coreutils
	READLINK='greadlink'
fi

# absolute path of this script, e.g. /home/user/bin/foo.sh
SCRIPT=`$READLINK -f $0`
# absolute path of current directory
SCRIPTPATH=`dirname $SCRIPT`

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

# create temporary directory
if [ -f ~/tmp ] || [ -h ~/tmp ] || [ -d ~/tmp ]; then
	rm -rf ~/tmp
fi
mkdir ~/tmp
# download dircolors-solarized
git clone git://github.com/seebi/dircolors-solarized.git ~/tmp/dircolors-solarized

cp ~/tmp/dircolors-solarized/dircolors.256dark ~/.dir_colors
ln -s ~/.powerline-oh-my-zsh-theme/powerline.zsh-theme ~/.oh-my-zsh/themes/

# delete temporary files
rm -rf ~/tmp

source ~/.zshrc

