# Powerlevel10k insta-prompt, Init Code that may require input go above this block;
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antigen
[ -f $HOME/antigen.zsh ] && source $HOME/antigen.zsh
[ -f $HOME/.antigenrc ] && source $HOME/.antigenrc

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

#------------------------------------------------------ Tmux -------------------------------------------------------- #

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

#---------------------------------------------------------------------------------------------------------------------#

# Display Hackerman-ness for people who don't understand terminals when done.
LOLCAT=$(which lolcat)
TMUX_COLS_WIDTH=$(tmux display -p '#{pane_width}-#{pane_height}')

figlet -Lcw $TMUX_COLS_WIDTH -f speed "Hackerman Mode 030" | $LOLCAT

