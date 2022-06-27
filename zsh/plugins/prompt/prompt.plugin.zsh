# Set prompt height 
if ! (( ${+_DOT_ZSH_PROMPT_HEIGHT} )); then 
    export _DOT_ZSH_PROMPT_HEIGHT=$(( 4 ))
fi

export fpath=( ${fpath[@]} ${DOT_ZSH}/plugins/prompt )

autoload -Uz ${DOT_ZSH}/plugins/prompt/__clear_prev_prompt
autoload -Uz add-zsh-hook

#Add to preexec hook
add-zsh-hook preexec __clear_prev_prompt

