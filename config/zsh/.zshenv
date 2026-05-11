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
# Prevent autosuggestions from blocking keystrokes; skip matching on long buffers.
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

export DOT_DEFAULT_LOL_MSG="Hackerman Mode 030"
export DOT_NEOVIM_LOL_MSG="NVIM 030"

# Cache PHP_VERSION keyed on php binary mtime — avoids forking php on every shell start.
() {
    local php_bin=/opt/homebrew/bin/php
    local cache_dir=${XDG_CACHE_HOME:-${HOME}/.cache}/dotfiles
    local cache_file=${cache_dir}/php_version
    local php_mtime=0 cache_mtime=0

    if zmodload -F zsh/stat b:zstat 2>/dev/null; then
        php_mtime=$(zstat +mtime ${php_bin} 2>/dev/null) || php_mtime=0
        cache_mtime=$(zstat +mtime ${cache_file} 2>/dev/null) || cache_mtime=0
    fi

    if [[ -s ${cache_file} && ${cache_mtime} -ge ${php_mtime} ]]; then
        PHP_VERSION=$(<${cache_file})
    else
        PHP_VERSION="${$( ${php_bin} -r 'echo PHP_VERSION;' 2>/dev/null )[1,3]}"
        mkdir -p ${cache_dir}
        print -r -- "${PHP_VERSION}" > ${cache_file}
    fi
}
export PHP_VERSION
export GITSTATUS_DIR=${HOME}/tools/gitstatus
export ZSH_EVALCACHE_DIR=${ZSH_EVALCACHE_DIR:-${ZDOTDIR}/.zsh-evalcache}

export BREW_HOME=/opt/homebrew/opt
export HOMEBREW_NO_INSTALL_FROM_API=1
