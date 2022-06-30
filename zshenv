#------------------------------------------------------ Paths --------------------------------------------------------#

export DOTFILES=${HOME}/.dotfiles
export DOT_ZSH=${DOTFILES}/zsh
export DOT_RC=${HOME}/.zshrc

export XDG_CONFIG=${HOME}/.config

#-------------------------------------------------- Applications -----------------------------------------------------#

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export DOT_PROMPT_HEIGHT=4

export EDITOR=nvim
export VISUAL=${EDITOR}

export LS_OVERRIDE='exa'
export LS_DEFAULT_ARGS="-aUhl --icons --no-time --no-permissions --octal-permissions --no-user --group-directories-first"
export CAT_OVERRIDE='bat'
export LAZYGIT_CONFIG=${XDG_CONFIG}/lazygit/config.yml 
export COMPOSER_DEFAULT_VENDOR="jascha030" 
export NPM_CHECK_INSTALLER="pnpm npm-check -u"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig

export TOOLCHAINS=swift

