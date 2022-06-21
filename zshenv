#----------------------------------------------------- Directories ---------------------------------------------------#

export DOTFILES=${HOME}/.dotfiles
export DOT_ZSH=${DOTFILES}/zsh
export XDG_CONFIG=${HOME}/.config

export DATA_FILES_DIR=${HOME}/.config/datafiles
export HISTFILE=${DATA_FILES_DIR}/.zsh_history 
export MYSQL_HISTFILE=${DATA_FILES_DIR}/.mysql_history

#----------------------------------------------------- Editor --------------------------------------------------------#

(( ${+VIM} && ${+VIMRUNTIME} && ${+MYVIMRC} )) && export VIM_TERM_MODE_ACTIVE=true || export VIM_TERM_MODE_ACTIVE=false

(( ${+commands[nvim]} )) && export EDITOR=nvim || export EDITOR=vim

export VISUAL=${EDITOR}

#---------------------------------------------------- Applications ---------------------------------------------------#

# For use inside .dotfiles
export LS_OVERRIDE='lsd'
export CAT_OVERRIDE='bat'

export LAZYGIT_CONFIG=${XDG_CONFIG}/lazygit/config.yml 

# Added for apps
export NPM_CHECK_INSTALLER="pnpm npm-check -u"
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig
export TOOLCHAINS=swift

