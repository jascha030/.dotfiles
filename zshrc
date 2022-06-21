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
local sources=(
  ${DOT_ZSH}/path
  ${HOME}/.cargo/env
)

fpath=(
  ${DOT_ZSH}/functions
  ${fpath[@]}
)

autoload -Uz ${DOT_ZSH}/functions/*(.:t)


#----------------------------------------------------- ZSH -----------------------------------------------------------#

# Create dirs if necessary.
assert_dirs "${required_dirs[@]}"

# Create files if necessary.
assert_files "${required_files[@]}"

# Safe-Source (if they exist) files.
safe_source "${sources[@]}"

typeset -aU path

load_antigen

#----------------------------------------------- Initializations -----------------------------------------------------# 

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Tab-tab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# FASD
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Prompt
eval "$(starship init zsh)"

# Load slow or not immediately necessary schmipschmap
eval "$(teleport-dir init)"

# Node
eval "$(fnm env)"

# Zoxide
eval "$(zoxide init zsh)"

source_zsh_dotfiles "aliases"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

lolmsg "${VIM_TERM_MODE_ACTIVE}" \
    "Hackerman Mode 030" \
    "NVIM 030"

#----------------------------- Display Profile output when enabled with $PROFILE_ZSH ---------------------------------#

if (( ${+PROFILE_ZSHRC} )) then   
  zprof
fi
