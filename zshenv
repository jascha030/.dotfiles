#------------------------------------------------------ Paths --------------------------------------------------------#

export DOTFILES=${HOME}/.dotfiles
export DOT_ZSH=${DOTFILES}/zsh
export XDG_CONFIG=${HOME}/.config
export DOT_RC=${HOME}/.zshrc

export DATA_FILES_DIR=${HOME}/.config/datafiles
export HISTFILE=${DATA_FILES_DIR}/.zsh_history 
export MYSQL_HISTFILE=${DATA_FILES_DIR}/.mysql_history

#-------------------------------------------------- Applications -----------------------------------------------------#

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export _DOT_ZSH_PROMPT_HEIGHT=4

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

