# --- Plugin List ---
zgen load chriskempson/base16-shell base16-tomorrow.dark.sh # base16-tomorrow color support

# --- Prezto Settings ---
zgen prezto '*:*' color 'yes' # default to turn on color for commands
zgen prezto 'editor' dot-expansion 'yes' # expand .... to ../..
zgen prezto 'history-substring-search' globbing-flags 'l' # See http://zsh.sourceforge.net/Doc/Release/Expansion.html#Globbing-Flags
zgen prezto 'history-substring-search:color' found 'underline'
zgen prezto 'history-substring-search:color' not-found 'bg=red'
zgen prezto prompt theme 'pure'

# --- Prezto Plugin List ---
zgen prezto
zgen prezto archive
zgen prezto command-not-found
zgen prezto completion
zgen prezto directory
zgen prezto dpkg
zgen prezto editor
zgen prezto environment
zgen prezto fasd
zgen prezto git
zgen prezto history
zgen prezto homebrew
zgen prezto node
zgen prezto osx
zgen prezto python
zgen prezto rsync
zgen prezto ruby
zgen prezto spectrum
zgen prezto syntax-highlighting && zgen prezto history-substring-search && zgen prezto prompt
zgen prezto tmux
zgen prezto utility && zgen prezto gnu-utility

