if zplug check BrandonRoehl/zsh-clean; then
	# Use single quote to allow the function to be evaluated every time not
	# being evaluated while assigning the prompt.
	local prompt_sym='%(!.#.❯)'
	local prompt_path='%F{blue}%5v%f'
	local prompt_vcs='%(1V. %F{242}%1v%2v%(3V. %F{cyan}%3v.)%f.)'
	local prompt_exec_time='%(4V. %F{215}%4v%f.)'
	local prompt_error_code='%(?..%F{red}$(nice_exit_code)$prompt_sym)'
	local prompt_last='%F{magenta}$prompt_sym%f '
	if [[ $SSH_CONNECTION != ''  ]]; then
		local prompt_username=' %F{white}%n@%m%f'
	fi
	ps1=(
		$prompt_newline $prompt_path $prompt_vcs $prompt_username $prompt_exec_time
		$prompt_newline $prompt_error_code $prompt_last
	)
	PS1="${(j..)ps1}"
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
