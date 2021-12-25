# Powerlevel10k insta-prompt, Init Code that may require input go above this block;
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antigen
[ -f $HOME/.dotfiles/antigen/antigen.zsh ] && source $HOME/.dotfiles/antigen/antigen.zsh
[ -f $HOME/.dotfiles/antigen/.antigenrc ] && source $HOME/.dotfiles/antigen/.antigenrc

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
export DOTZSH="${DOTFILES}/zsh"

# Project directories
export WORKINGDIR="${HOME}/.workingDir"
export PROJECTS="${WORKINGDIR}/Projects"
export SBPROJECTS="${PROJECTS}/Socialbrothers"

# Brewfile
export HOMEBREW_BUNDLE_FILE="${DOTFILES}/macos/Brewfile"

# Editor globals
export PSTORM='phpstorm'
export NVIM='nvim'
export EDITOR=$NVIM
export VISUAL=$NVIM

export DOTCONFIGDIR="${DOTFILES}/config"

export NPM_CHECK_INSTALLER="pnpm npm-check -u"

#----------------------------------------------- Sources & Paths -----------------------------------------------------#

[[ ! -f "${DOTZSH}/aliases.zsh" ]] || source "${DOTZSH}/aliases.zsh"
[[ ! -f "${DOTZSH}/path.zsh" ]] || source "${DOTZSH}/path.zsh"

# Linked ZSH files
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

# PyEnv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(fnm env)"

# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Output funny msg when done
LOLCAT=$(which lolcat)
TMUX_COLS_WIDTH=$(tmux display -p '#{pane_width}-#{pane_height}')

figlet -Lcw $TMUX_COLS_WIDTH -f speed "Hackerman Mode 030" | $LOLCAT
