zplug "bobthecow/git-flow-completion", use:"git-flow-completion.zsh" # completion for git-flow
zplug "bric3/nice-exit-code"
zplug "chriskempson/base16-shell", use:"scripts/base16-tomorrow-night.sh" # base16 tomorrow color support
zplug "chrissicool/zsh-256color"
zplug "djui/alias-tips" # remind me of my alias
zplug "mafredri/zsh-async" # perform task asynchronously (needed by pure theme)
zplug "modules/archive", from:prezto
zplug "modules/command-not-found", from:prezto, if:"[ \"$(uname -s)\" = \"Linux\" ]"
zplug "modules/completion", from:prezto # auto-completion with menu
zplug "modules/directory", from:prezto
zplug "modules/dpkg", from:prezto, if:"[ \"$(uname -s)\" = \"Linux\" ]"
zplug "modules/editor", from:prezto
zplug "modules/environment", from:prezto
zplug "modules/fasd", from:prezto
zplug "modules/git", from:prezto
zplug "modules/gnu-utility", from:prezto
zplug "modules/history", from:prezto
zplug "modules/homebrew", from:prezto, if:"[ \"$(uname -s)\" = \"Darwin\" ]"
zplug "modules/node", from:prezto
zplug "modules/osx", from:prezto
zplug "modules/python", from:prezto
zplug "modules/rsync", from:prezto
zplug "modules/ruby", from:prezto
zplug "modules/spectrum", from:prezto
zplug "zpm-zsh/linuxbrew", if:"[ \"$(uname -s)\" = \"Linux\" ]"
zplug "modules/tmux", from:prezto
zplug "modules/utility", from:prezto, defer:1 # need to be loaded after gnu-utility
zplug "sindresorhus/pure", use:"pure.zsh", as:theme
zplug "tarrasch/zsh-autoenv"
zplug "unixorn/git-extra-commands" # a collection of useful extra git scripts
zplug "unixorn/warhol.plugin.zsh"
zplug "zdict/zdict.sh" # zdict completion scripts
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2 # avoid the setting overwritten by zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:1 # avoid the setting overwritten by zsh-autosuggestions
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:utility:diff' color 'yes'
zstyle ':prezto:module:utility:ls' color 'yes'
zstyle ':prezto:module:utility:make' color 'yes'
zstyle ':prezto:module:utility:wdiff' color 'yes'
