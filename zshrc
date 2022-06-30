#------------------------------------ Profile zshrc when enabled with $PROFILE_ZSH -----------------------------------#

if (( ${+PROFILE_ZSHRC} )); then zmodload zsh/zprof ;fi

#------------------------------------------------ ZSH Configurations -------------------------------------------------#

setopt extended_glob;

# Hacky fix when first window of wezterm messes up lolmsg placement.
# Related to Hammerspoon handling of application on quake.
if (( ${LINES} == 24 )); then 
  until (( ${LINES} > 24)); do exec zsh -l; done
fi

# Required dirs.
export DOT_REQUIRED_DIRS=( ${DATA_FILES_DIR} )
 
# Required files.
export DOT_REQUIRED_FILES=(
    ${DATA_FILES_DIR}/.zsh_history 
    ${DATA_FILES_DIR}/.mysql_history
)

# Files to be sourced.
export DOT_SOURCES=( 
    ${DOT_ZSH}/plugins/prompt/prompt.plugin.zsh
    ${DOT_ZSH}/plugins/auto-ls
    ${HOME}/.cargo/env 
    ${DOT_ZSH}/plugins/lolmsg/lolmsg.plugin.zsh
    ${HOME}/.config/tabtab/zsh/__tabtab.zsh 
)

# Final ZSH files to load, files should reside in $DOT_ZSH dir.
export DOT_AFTER_INIT_SOURCES=( 
    ${DOTFILES}/aliases
    ${DOT_ZSH}/aliases
    ${HOME}/.fzf.zsh
)

#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${DOT_ZSH}/init ]] && source ${DOT_ZSH}/init

#----------------------------- Display Profile output when enabled with $PROFILE_ZSH ---------------------------------#

if (( ${+PROFILE_ZSHRC} )); then clear; tput rmcup; zprof; unset PROFILE_ZSHRC; fi

