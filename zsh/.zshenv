#!/usr/bin/env zsh

[ -f "$HOME/.env" ] || ln -s "$HOME/.dotfiles/.env" "$HOME/.env"

# Source shell env
. "$HOME/.env"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ ! -d "$ZDOTDIR" ]] && ln -s "$DOT_ZSH" "$ZDOTDIR" # Symlink zdotdir if it doesn't exist yet.

export ZSH_HIGHLIGHT_STYLES
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export DOT_DEFAULT_LOL_MSG="Hackerman Mode 030"
export DOT_NEOVIM_LOL_MSG="NVIM 030"

