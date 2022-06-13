export DOTFILES="${HOME}/.dotfiles"
export DOTHOME="${DOTFILES}/home"

export PSTORM='phpstorm'
export NVIM='nvim'
export EDITOR=$NVIM
export VISUAL=$NVIM

export NPM_CHECK_INSTALLER="pnpm npm-check -u"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export TOOLCHAINS=swift
export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)

export DATA_FILES_DIR=$HOME/.config/datafiles
export HISTFILE=$DATA_FILES_DIR/.zsh_history 
export MYSQL_HISTFILE=$DATA_FILES_DIR/.mysql_history

[[ ! -d $DATA_FILES_DIR ]] && mkdir -p $DATA_FILES_DIR
[[ ! -f $DATA_FILES_DIR/.zsh_history ]] && touch $DATA_FILES_DIR/.zsh_history
[[ ! -f $DATA_FILES_DIR/.mysql_history ]] && touch $DATA_FILES_DIR/.mysql_history

[[ -f "$DOTFILES"/zsh/.path.zsh ]] && source "$DOTFILES"/zsh/.path.zsh
[[ -r "$HOME"/.cargo/env ]] && source "$HOME"/.cargo/env
[[ -f "$HOME/.zfunc" ]] && fpath+=$HOME/.zfunc

ANTIGEN_CACHE=false

[[ -f $HOME/antigen.zsh ]] && source $HOME/antigen.zsh
[[ -f $HOME/.antigenrc ]] && source $HOME/.antigenrc

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Silently start job to update dotfiles w/ RCM.
() {
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR  
 
  sh "${DOTFILES}/rcup" &
  disown &>/dev/null
}

auto-ls-lsd () {
	lsd -Ahl --color --group-dirs=first
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
AUTO_LS_COMMANDS=(lsd git-status)

ZSH_FILES=(
  ".tmux.zsh",
  ".aliases.zsh"
)

for DOT in $ZSH_FILES; do
	[ -f $HOME/.dotfiles/zsh/$DOT ] && source $HOME/.dotfiles/zsh/$DOT
done

[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PSTORM='phpstorm'
export NVIM='nvim'
export EDITOR=$NVIM
export VISUAL=$NVIM

export NPM_CHECK_INSTALLER="pnpm npm-check -u"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export TOOLCHAINS=swift
export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)

export DATA_FILES_DIR=$HOME/.config/datafiles
export HISTFILE=$DATA_FILES_DIR/.zsh_history 
export MYSQL_HISTFILE=$DATA_FILES_DIR/.mysql_history

[[ ! -d $DATA_FILES_DIR ]] && mkdir -p $DATA_FILES_DIR
[[ ! -f $DATA_FILES_DIR/.zsh_history ]] && touch $DATA_FILES_DIR/.zsh_history
[[ ! -f $DATA_FILES_DIR/.mysql_history ]] && touch $DATA_FILES_DIR/.mysql_history

eval "$(fnm env)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# eval "$(teleport-dir init)"
# eval "$(zoxide init zsh)"
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

