alias tmux="TERM=screen-256color tmux"

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

