if zplug check modules/editor; then
	zstyle ':prezto:module:editor' dot-expansion 'yes'
fi

if zplug check modules/utility; then
	zstyle ':prezto:module:utility:diff' color 'yes'
	zstyle ':prezto:module:utility:ls' color 'yes'
	zstyle ':prezto:module:utility:make' color 'yes'
	zstyle ':prezto:module:utility:wdiff' color 'yes'
fi

if zplug check sindresorhus/pure; then
	# Use single quote to allow the function to be evaluated every time not being evaluated while assigning the prompt.
	local PROMPT='%(?.%F{magenta}.%F{red}$(nice_exit_code)${PURE_PROMPT_SYMBOL:-❯}%F{magemta})${PURE_PROMPT_SYMBOL:-❯}%f '
fi

if zplug check zsh-users/zsh-history-substring-search; then
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold,underline'
	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white'
	HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='l'
    bindkey '\eOA' history-substring-search-up # up key
    bindkey '\eOB' history-substring-search-down # down key
fi

if zplug check zsh-users/zsh-autosuggestions; then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=236'
fi
