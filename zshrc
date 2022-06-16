#zmodload zsh/zprof ---------------------------------------------- Custom configurations ------------------------------------------------#

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
  ${DOTFILES}/shell/path
  ${HOME}/.cargo/env
)

# Zsh scripts required by .zshrc
local shell_files=(
  aliases
)

# Autoload functions.
fpath=(
  ${DOTFILES}/zsh/zfunc
  ${fpath[@]}
)

autoload -Uz ${DOTFILES}/zsh/zfunc/*(.:t)

#----------------------------------------------------- ZSH -----------------------------------------------------------#

# Create dirs if necessary.
df_assert_dir "${required_dirs[@]}"

# Create files if necessary.
df_assert_file "${required_files[@]}"

# Safe-Source (if they exist) files.
df_source "${sources[@]}"

typeset -aU path

df_load_antigen

#----------------------------------------------- Initializations -----------------------------------------------------# 

df_dot_source "${shell_files[@]}"

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Tab-tab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true


# FASD
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

#------------------------------------------------- 🚀 Prompt 🚀 ------------------------------------------------------#

eval "$(starship init zsh)"

#----------------------------------------------- Lower Prio stuff ----------------------------------------------------# 

# Load slow or not immediately necessary schmipschmap
eval "$(teleport-dir init)"

# Node
eval "$(fnm env)"

# Python
# eval "$(pyenv init --path && pyenv init -)"

# Zoxide
eval "$(zoxide init zsh)"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

df_lol_msg "${VIM_TERM_MODE_ACTIVE}" "Hackerman Mode 030" "NVIM 030"
  
#zprof
