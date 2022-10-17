#------------------------------------------------------ Paths --------------------------------------------------------#

export DOTFILES=${HOME}/.dotfiles
export DOT_ZSH=${DOTFILES}/zsh
export DOT_RC=${HOME}/.zshrc
export XDG_CONFIG=${HOME}/.config
export XDG_CONFIG_HOME=${HOME}/.config
export ZDOTDIR=${HOME}/zsh
export DEV=${HOME}/.development/Projects

if [[ ! -d $ZDOTDIR ]]; then
    ln -s $DOT_ZSH $ZDOTDIR
fi

export EDITOR=nvim
export VISUAL=${EDITOR}
export MANPAGER=${EDITOR}" +Man!"
# export MANPAGER=/usr/local/bin/most

export COMPOSER_DEFAULT_VENDOR="jascha030"
export NPM_CHECK_INSTALLER="pnpm npm-check -u"

export TOOLCHAINS=swift
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig

