#!/usr/bin/env zsh

skip_global_compinit=1

# Source shell env or link it to HOME dir, if it doesn't exist yet.
[ -f "$HOME/.env" ] || ln -s "$HOME/.dotfiles/.env" "$HOME/.env"
. "$HOME/.env"

export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export DOT_ZSH=${DOTFILES}/config/zsh

# Symlink zdotdir if it doesn't exist yet.
[[ ! -d "$ZDOTDIR" ]] && ln -s "$DOT_ZSH" "$ZDOTDIR"

# Built-in highlighting
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export DOT_DEFAULT_LOL_MSG="Hackerman Mode 030"
export DOT_NEOVIM_LOL_MSG="NVIM 030"
export PHP_VERSION=${$(/opt/homebrew/bin/php -r 'echo PHP_VERSION;')[1,3]}
export ZSH_EVALCACHE_DIR=${ZSH_EVALCACHE_DIR:-"$ZDOTDIR/.zsh-evalcache"}
