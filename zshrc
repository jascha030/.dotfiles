zmodload zsh/zprof
#---------------------------------------------- Custom configurations ------------------------------------------------#

setopt extended_glob;

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
ZSH_TMUX_AUTOSTART=true

auto-ls-lsd () { lsd -Ahl --color --group-dirs=first }
AUTO_LS_COMMANDS=(lsd git-status)

#---------------------------------------------- Assure dirs/files ----------------------------------------------------#

# Dirs used by `df_assert_dir`
local required_dirs=(
  $DATA_FILES_DIR
)

# Files used by `df_assert_file`
local required_files=(
  $DATA_FILES_DIR/.zsh_history 
  $DATA_FILES_DIR/.mysql_history
)

# Files to be sourced 
local sources=(
  $DOTFILES/zsh/.path.zsh
  $HOME/.cargo/env
)

# Zsh scripts required by .zshrc
local zsh_files=(
  ".aliases.zsh"
)

# Autoload functions.
fpath=(
  $DOTFILES/zsh/zfunc
  ${fpath[@]}
)

autoload -Uz $DOTFILES/zsh/zfunc/*(.:t)

#---------------------------------------------------------------------------------------------------------------------#

# Create dirs if necessary.
df_assert_dir "${required_dirs[@]}"

# Create files if necessary.
df_assert_file "${required_files[@]}"

# Safe-Source (if they exist) files.
df_source "${sources[@]}"

eval "$(zoxide init zsh)"  
eval "$(fnm env)"
eval "$(teleport-dir init)"

df_load_antigen

df_start_rcup && unset -f df_start_rcup

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

#----------------------------------------------------- Oewen T'moks --------------------------------------------------#

alias tmux="TERM=xterm-256color tmux"

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
   [[ -v VIM && -v VIMRUNTIME && -v MYVIMRC  ]] && VIM_TERM_MODE_ACTIVE=true || VIM_TERM_MODE_ACTIVE=false

   if [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" && $VIM_TERM_MODE_ACTIVE != true ]]; then
 	  ZSH_TMUX_AUTOSTART=true

 	  if which tmux 2>&1 >/dev/null; then
    	if [ $TERM != "tmux-256color" ] && [  $TERM != "screen" ]; then
 			  tmux attach -t main || tmux new -s main; exit
     	fi
 	  fi
  fi
fi

# Load other zsh dotfiles.
df_dot_source "${zsh_files[@]}"

# Tab-tab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Finally init prompt
eval "$(starship init zsh)"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

df_lol_msg "${VIM_TERM_MODE_ACTIVE}"

