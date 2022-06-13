export DOTFILES="${HOME}/.dotfiles"
export DOTHOME="${DOTFILES}/home"

export DATA_FILES_DIR=$HOME/.config/datafiles
export HISTFILE=$DATA_FILES_DIR/.zsh_history 
export MYSQL_HISTFILE=$DATA_FILES_DIR/.mysql_history

export PSTORM=phpstorm
export NVIM=nvim

export EDITOR="${NVIM}"
export VISUAL="${NVIM}"

export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export TOOLCHAINS=swift
export NPM_CHECK_INSTALLER="pnpm npm-check -u"

