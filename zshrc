#! /bin/zsh
# Path of oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# theme name (theme in .oh-my-zsh/theme)
ZSH_THEME="powerline"

# setup plugin (plugin in .oh-my-zsh/plugin)
plugins=()

OS=$(uname)
echo $OS

if [ "$OS" = 'Linux' ]; then

elif [ "$OS" = 'Darwin' ]; then
	plugins+=osx
fi

# check git
if which git &> /dev/null; then
	plugins+=git
else
	echo "no git"
fi

echo $plugins




