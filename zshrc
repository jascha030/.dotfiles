if ! (( ${+_select_shell} )); then
    source ${HOME}/.dotfiles/zsh/zshrc
else 
    source ${HOME}/.dotfiles/shell/selectshell
fi

