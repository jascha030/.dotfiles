# Powerlevel10k insta-prompt, Init Code that may require input go above this block;
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antigen
[ -f $HOME/antigen.zsh ] && source $HOME/antigen.zsh
[ -f $HOME/.antigenrc ] && source $HOME/.antigenrc

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

#------------------------------------------------------ Tmux -------------------------------------------------------- #

[[ -v VIM && -v VIMRUNTIME && -v MYVIMRC  ]] && VIM_TERM_MODE_ACTIVE=true || VIM_TERM_MODE_ACTIVE=false

if [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" && $VIM_TERM_MODE_ACTIVE != true ]]; then
	ZSH_TMUX_AUTOSTART=true

	# Workaround because of macos' outdated ncurses.
	# Figured out using: https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
	if [[ $TERM == "tmux-256color" ]]; then
    	export TERM=screen-256color
	fi

	if which tmux 2>&1 >/dev/null; then
   	if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
			tmux attach -t main || tmux new -s main; exit
   	fi
	fi
fi

#--------------------------------------------------- Globals -------------------------------------------------------- #

export DOTFILES="${HOME}/.dotfiles"
export DOTHOME="${DOTFILES}/home"

# Brewfile @todo

# Editor globals
export PSTORM='phpstorm'
export NVIM='nvim'
export EDITOR=$NVIM
export VISUAL=$NVIM

export NPM_CHECK_INSTALLER="pnpm npm-check -u"

#----------------------------------------------- Sources & Paths -----------------------------------------------------#

ZSH_FILES=(
	".path.zsh"
	".aliases.zsh"
	".p10k.zsh"
	".fzf.zsh"
)

for DOT in $ZSH_FILES; do
	[ -f $HOME/$DOT ] && source $HOME/$DOT
done

#----------------------------------------------- Auto-ls settings ----------------------------------------------------#

auto-ls-lsd () {
	lsd -Ahl --color --group-dirs=first
}

AUTO_LS_COMMANDS=(lsd git-status)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

#----------------------------------------------- Other Init & Added by installs --------------------------------------#

# Rust
source "${HOME}/.cargo/env"
. "${HOME}/.cargo/env"

# PyEnv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(fnm env)"

# tabtab
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ $TERMINAL_EMULATOR == "JetBrains-JediTerm" ]] then
	unset ITERM_SHELL_INTEGRATION_INSTALLED && p10k reload
fi

#---------------------------------------------------------------------------------------------------------------------#

# Display Hackerman-ness for people who don't understand terminals when done.
LOLCAT=$(which lolcat)
TMUX_COLS_WIDTH=$(tmux display -p '#{pane_width}-#{pane_height}')

[[ $VIM_TERM_MODE_ACTIVE == false ]] && LOLCAT_MSG_TEXT="Hackerman Mode 030" || LOLCAT_MSG_TEXT="NEOVIM 030"
[[ $VIM_TERM_MODE_ACTIVE == false ]] && LOLCAT_MSG_FONT="speed" || LOLCAT_MSG_FONT="larry3d"

if [[ $VIM_TERM_MODE_ACTIVE == true ]]; then
  sleep 1
fi

clear

figlet -Lcw $TMUX_COLS_WIDTH -f $LOLCAT_MSG_FONT $LOLCAT_MSG_TEXT | $LOLCAT

