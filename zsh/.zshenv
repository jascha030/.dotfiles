# Export globals
export DOTFILES="${HOME}/.dotfiles"
export DOTHOME="${DOTFILES}/home"

# Editor globals
export PSTORM='phpstorm'
export NVIM='nvim'
export EDITOR=$NVIM
export VISUAL=$NVIM

export NPM_CHECK_INSTALLER="pnpm npm-check -u"
export MYSQL_HISTFILE="${HOME}/.config/datafiles/.mysql_history"

# Rust
[[ -r "$HOME"/.cargo/env ]] && source "$HOME"/.cargo/env

fpath+=$HOME/.zfunc

