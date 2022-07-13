#------------------------------------------------------ Paths --------------------------------------------------------#

export DOTFILES=${HOME}/.dotfiles
export DOT_ZSH=${DOTFILES}/zsh
export DOT_RC=${HOME}/.zshrc
export XDG_CONFIG=${HOME}/.config
export BUN_INSTALL=${HOME}/.bun
export LAZYGIT_CONFIG=${XDG_CONFIG}/lazygit/config.yml 

#-------------------------------------------------- Applications -----------------------------------------------------#

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export EDITOR=nvim
export VISUAL=${EDITOR}
export MANPAGER=/usr/local/bin/most
export LS_OVERRIDE='lsd'
export CAT_OVERRIDE='bat'
export COMPOSER_DEFAULT_VENDOR="jascha030" 
export NPM_CHECK_INSTALLER="pnpm npm-check -u"
export FZF_DEFAULT_OPTS="--info=inline --border --padding=1"

export TOOLCHAINS=swift
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig

