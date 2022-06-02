# Powerlevel10k insta-prompt, Init Code that may require input go above this block;
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

#------------------------------------------------------ Tmux -------------------------------------------------------- #

alias tmux="TERM=xterm-256color tmux"

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then

  [[ -v VIM && -v VIMRUNTIME && -v MYVIMRC  ]] && VIM_TERM_MODE_ACTIVE=true || VIM_TERM_MODE_ACTIVE=false

  if [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" && $VIM_TERM_MODE_ACTIVE != true ]]; then
	  ZSH_TMUX_AUTOSTART=true

	  # Workaround because of macOS' outdated ncurses.
	  # Figured out using: https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
	  #if [[ $TERM == "tmux-256color" ]]; then
    #  	export TERM=screen-256color
	  #fi

	  if which tmux 2>&1 >/dev/null; then
   	  if [ $TERM != "tmux-256color" ] && [  $TERM != "screen" ]; then
			  tmux attach -t main || tmux new -s main; exit
   	  fi
	  fi
  fi
fi
#----------------------------------------------- Sources & Paths -----------------------------------------------------#

source $HOME/.p10k.zsh

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

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

#----------------------------------------- Other Init & Added by installs --------------------------------------------#

# PyEnv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(fnm env)"

# Teleport-dir (Rust)
eval "$(teleport-dir init)"

# tab-tab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ $TERMINAL_EMULATOR == "JetBrains-JediTerm" ]] then
	unset ITERM_SHELL_INTEGRATION_INSTALLED && p10k reload
fi

#------------------- Display Hackerman-ness for people who don't understand terminals when done ----------------------#
_RANDOM_LC_NUM=$(( ( RANDOM % 10 )  + 1 ))
[[ $_RANDOM_LC_NUM > 5 ]] && RANDOM_LC=$(which lolcat) || RANDOM_LC=$(which lolcrab) 

typeset -A fonts
fonts=(
  [1]="larry3d"
  [2]="speed"
  [3]="smisome1"
  [4]="doom"
  [5]="cosmic"
  [6]="isometric1"
  [7]="isometric3"
  [8]="trek"
  [9]="smkeyboard"
  [10]="roman"
)

#LOLCAT_MSG_FONT="speed"
LOLCAT_MSG_FONT=$fonts[$_RANDOM_LC_NUM]
[[ $VIM_TERM_MODE_ACTIVE == false ]] && LOLCAT_MSG_TEXT="Hackerman Mode 030" || LOLCAT_MSG_TEXT="NEOVIM 030"
[[ $VIM_TERM_MODE_ACTIVE == false ]] && COLS_W=$(tmux display -p '#{pane_width}-#{pane_height}') || COLS_W=$(tput cols)

clear

figlet -Lcw $COLS_W -f $LOLCAT_MSG_FONT $LOLCAT_MSG_TEXT | $RANDOM_LC

