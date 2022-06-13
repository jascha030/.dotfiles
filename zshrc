setopt extended_glob; 

# Some options
ZSH_FILES=(
  ".aliases.zsh"
)

# Autoload functions.
fpath=($DOTFILES/zfunc $fpath)
autoload -Uz $DOTFILES/zfunc/*(.:t)

# Create dirs and files if necessary.
df_assert_dir $DATA_FILES_DIR

df_assert_file \
    $DATA_FILES_DIR/.zsh_history \
    $DATA_FILES_DIR/.mysql_history

# Safe-Source (if they exist) files.
df_source \
    $DOTFILES/zsh/.path.zsh \
    $HOME/.cargo/env
    
eval "$(zoxide init zsh)"  

# Antigen
df_source $HOME/antigen.zsh    
if [[ -f "${HOME}/.antigenrc" ]]; then
  antigen init "${HOME}/.antigenrc"
fi

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Silently start job to update dotfiles w/ RCM.
() {
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR   
  sh "${DOTFILES}/rcup" &
  disown &>/dev/null
}

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

for DOT in $ZSH_FILES; do
    df_source "${DOTFILES}/zsh/${DOT}"
done

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

# Auto-ls
auto-ls-lsd () {
	lsd -Ahl --color --group-dirs=first
}

# Load other zsh dotfiles.
AUTO_LS_COMMANDS=(lsd git-status)


# TabTab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

eval "$(fnm env)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(teleport-dir init)"
eval "$(starship init zsh)"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

() {
  _RANDOM_LC_NUM=$(( ( RANDOM % 10 )  + 1 ))
  [[ $_RANDOM_LC_NUM > 5 ]] && RANDOM_LC=$(which lolcat) || RANDOM_LC=$(which lolcrab) 

  typeset -A fonts
  
  fonts=(
    [1]="larry3d"
    [2]="speed"
    [3]="smisome1"
    [4]="doom"
    [5]="roman"
    [6]="isometric1"
    [7]="isometric3"
    [8]="roman"
    [9]="smkeyboard"
    [10]="roman"
  )

  LOLCAT_MSG_FONT=$fonts[$_RANDOM_LC_NUM]
 
  [[ $VIM_TERM_MODE_ACTIVE == false ]] && LOLCAT_MSG_TEXT="Hackerman Mode 030" || LOLCAT_MSG_TEXT="NEOVIM 030"
  [[ $VIM_TERM_MODE_ACTIVE == false ]] && COLS_W=$(tmux display -p '#{pane_width}-#{pane_height}') || COLS_W=$(tput cols)

  clear
  
  figlet -Lcw $COLS_W -f $LOLCAT_MSG_FONT $LOLCAT_MSG_TEXT | $RANDOM_LC
}

