#---------------------------------- Profile zshrc when enabled with $PROFILE_ZSH -------------------------------------#

if (( ${+PROFILE_ZSHRC} )); then 
    zmodload zsh/zprof 
fi

#---------------------------------------------- Custom configurations ------------------------------------------------#

setopt extended_glob;

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

ZSH_TMUX_AUTOSTART=true
auto-ls-lsd () { lsd -Ahl --color --group-dirs=first }
AUTO_LS_COMMANDS=(lsd git-status)

#---------------------------------------------- Assure dirs/files ----------------------------------------------------#

# Dirs used by `df_assert_dir`
local required_dirs=(
  ${DATA_FILES_DIR}
)

# Files used by `df_assert_file`
local required_files=(
  ${DATA_FILES_DIR}/.zsh_history 
  ${DATA_FILES_DIR}/.mysql_history
)

# Files to be sourced 
local sources=( ${DOT_ZSH}/path ${HOME}/.cargo/env )

function _merge_arrays {
    return ( "${1[@]}" "${2[@]}" )
}

function _load_dot_functions {
    local AUTOLOAD_DIRS=( ${DOT_ZSH}/functions ) 
    local COMP_DIRS=( ${DOT_ZSH}/completions ) 
    local PLUGIN_DIRS=( ${DOT_ZSH}/plugins )
    
    (( ${+DOT_AUTOLOAD_DIRS} )) && $AUTOLOAD_DIRS=_merge_arrays "$DOT_AUTOLOAD_DIRS" "$AUTOLOAD_DIRS"
    (( ${+DOT_COMP_DIRS} ))     && $COMP_DIRS=_merge_arrays "$DOT_COMP_DIRS" "$COMP_DIRS"
    (( ${+DOT_PLUGIN_DIRS} ))   && $PLUGIN_DIRS=_merge_arrays "$DOT_PLUGIN_DIRS" "$PLUGIN_DIRS"
    
    export fpath=( "${AUTOLOAD_DIRS[@]}" "${COMP_DIRS[@]}" "${PLUGIN_DIRS[@]}" "${fpath[@]}" )
    
    # Autoload functions.
    local autoload_f
    for autoload_f in ${AUTOLOAD_DIRS[@]}; do autoload -Uz ${autoload_f}/*(.:t); done
}

_load_dot_functions

#----------------------------------------------------- ZSH -----------------------------------------------------------#

assert_dirs "${required_dirs[@]}"
assert_files "${required_files[@]}"
safe_source "${sources[@]}"

typeset -aU path

load_antigen

[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

#----------------------------------------------- Initializations -----------------------------------------------------# 

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
eval "$(starship init zsh)"
eval "$(teleport-dir init)"
eval "$(fnm env)"
eval "$(zoxide init zsh)"

source_zsh_dotfiles "aliases"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

lolmsg "${VIM_TERM_MODE_ACTIVE}" "Hackerman Mode 030" "NVIM 030"

#----------------------------- Display Profile output when enabled with $PROFILE_ZSH ---------------------------------#

if (( ${+PROFILE_ZSHRC} )) then   
  zprof
fi
