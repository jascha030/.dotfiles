# Clean up annoying history files .etc (place them in $HOME/.config/datafiles
[ -f $HOME/.dotfiles/zsh/.data.zsh ] && source $HOME/.dotfiles/zsh/.data.zsh

# Antigen
[ -f $HOME/antigen.zsh ] && source $HOME/antigen.zsh
[ -f $HOME/.antigenrc ] && source $HOME/.antigenrc

# fasd
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Silently start job to update dotfiles w/ RCM.
() {
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  
  sh "${DOTFILES}/rcup" &

  disown &>/dev/null
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

#------------------------------------------------------ Tmux -------------------------------------------------------- #

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

#----------------------------------------------- Sources & Paths -----------------------------------------------------#

ZSH_FILES=(
    ".path.zsh"
    ".aliases.zsh"
    ".fzf.zsh"
)

for DOT in $ZSH_FILES; do
	[ -f $HOME/.dotfiles/zsh/$DOT ] && source $HOME/.dotfiles/zsh/$DOT
done

#----------------------------------------------- Auto-ls settings ----------------------------------------------------#

auto-ls-lsd () {
	lsd -Ahl --color --group-dirs=first
}

AUTO_LS_COMMANDS=(lsd git-status)

#----------------------------------------- Other Init & Added by installs --------------------------------------------#

# tab-tab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Python PyEnv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# NodeJS version management
eval "$(fnm env)"

# Teleport-dir (Rust)
eval "$(teleport-dir init)"

#-------------------------------------------- ✨ 🚀 Init SpaceShip 🚀 ✨ ---------------------------------------------#

eval "$(starship init zsh)"

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#

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

#LOLCAT_MSG_FONT="speed"
LOLCAT_MSG_FONT=$fonts[$_RANDOM_LC_NUM]

[[ $VIM_TERM_MODE_ACTIVE == false ]] && LOLCAT_MSG_TEXT="Hackerman Mode 030" || LOLCAT_MSG_TEXT="NEOVIM 030"
[[ $VIM_TERM_MODE_ACTIVE == false ]] && COLS_W=$(tmux display -p '#{pane_width}-#{pane_height}') || COLS_W=$(tput cols)

clear

figlet -Lcw $COLS_W -f $LOLCAT_MSG_FONT $LOLCAT_MSG_TEXT | $RANDOM_LC

