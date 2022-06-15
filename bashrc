export DOTFILES=${HOME}/.dotfiles 

function df_source {
  local p 
  
  for p in "$@"; do
    [[ -f "${p}" ]] && source "${p}" 
  done
}

dot_sources=(
  ${DOTFILES}/shell/environment
  ${DOTFILES}/shell/path
  ${HOME}/.fzf.bash
  ${HOME}/.cargo/env
)

dot_init=()

