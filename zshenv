export DOTFILES=${HOME}/.dotfiles
export DATA_FILES_DIR=${HOME}/.config/datafiles
export HISTFILE=${DATA_FILES_DIR}/.zsh_history 
export MYSQL_HISTFILE=${DATA_FILES_DIR}/.mysql_history

export PSTORM=phpstorm
export NVIM=nvim
export EDITOR=${NVIM}
export VISUAL=${NVIM}

export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig

export TOOLCHAINS=swift
export NPM_CHECK_INSTALLER="pnpm npm-check -u"

if [[ -v VIM && -v VIMRUNTIME && -v MYVIMRC  ]]; then 
  export VIM_TERM_MODE_ACTIVE=true 
else
  export VIM_TERM_MODE_ACTIVE=false
fi


