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

# Source $PATH
[[ -f "$DOTFILES"/zsh/.path.zsh ]] && source "$DOTFILES"/zsh/.path.zsh

export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)

# CPPFLAGS for openssl@1.1
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# Swift
export TOOLCHAINS=swift

# export LUA_PATH="${HOME}/.config/wezterm/?/?.lua;;"

# Rust
[[ -r "$HOME"/.cargo/env ]] && source "$HOME"/.cargo/env

# Add rustup completions to $fpath
fpath+=$HOME/.zfunc

# Zoxide 
eval "$(zoxide init zsh)"

export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)
export TOOLCHAINS=swift
