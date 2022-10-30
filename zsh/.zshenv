#!/usr/bin/env zsh

[ -f "$HOME/.env" ] || ln -s "$HOME/.dotfiles/.env" "$HOME/.env"
source "$HOME/.env"
