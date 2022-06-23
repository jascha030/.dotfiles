#------------------------------------ Profile zshrc when enabled with $PROFILE_ZSH -----------------------------------#

if (( ${+PROFILE_ZSHRC} )); then 
    zmodload zsh/zprof 
fi

#------------------------------------------------ ZSH Configurations -------------------------------------------------#

# Zsh opts.
setopt extended_glob;

# Highlight style.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

# Required dirs.
export DOT_REQUIRED_DIRS=( ${DATA_FILES_DIR} )
 
# Required files.
export DOT_REQUIRED_FILES=(
    ${DATA_FILES_DIR}/.zsh_history 
    ${DATA_FILES_DIR}/.mysql_history
)

# Files to be sourced.
export DOT_SOURCES=( 
    ${DOT_ZSH}/plugins/auto-ls
    ${HOME}/.cargo/env 
    ${HOME}/.config/tabtab/zsh/__tabtab.zsh 
)

# export DOT_PLUGINS=( )

# Final ZSH files to load, files should reside in $DOT_ZSH dir.
export DOT_AFTER_INIT_SOURCES=( 
    ${DOTFILES}/aliases
    ${DOT_ZSH}/aliases
)

# Normal msg displayed with figlet in funky colors.
export DOT_DEFAULT_LOL_MSG="Hackerman Mode 030"   

# Alt msg displayed when in Neovim term.
export DOT_NEOVIM_LOL_MSG="NVIM 030"

#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${DOT_ZSH}/init ]] && source ${DOT_ZSH}/init

#----------------------------- Display Profile output when enabled with $PROFILE_ZSH ---------------------------------#

if (( ${+PROFILE_ZSHRC} )); then   
  unset PROFILE_ZSHRC
  
  zprof
fi

