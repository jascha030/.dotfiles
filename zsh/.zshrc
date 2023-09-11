#!/usr/bin/env zsh

# shellcheck disable=SC2093,SC1091,SC2155

# Conditionals, if current term is not in neovim .
if ! (( ${+VIM} && ${+VIMRUNTIME} && ${+MYVIMRC} )); then
    # Hacky fix when first window of wezterm messes up lolmsg placement.
    [[ "$TERM_PROGRAM" == "WezTerm" ]] && (( LINES == 24 )) && { until (( LINES > 24 )); do exec zsh -l; done; }
fi

setopt autocd extendedglob nomatch menucomplete traps_async
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES=(
    autodirectory   'fg=10,underline'
    arg0            'fg=10'
    suffix-alias    'fg=10,underline'
    bracket-level-2 'fg=10,bold'
)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

export DOT_COMP_DIRS=(
    "${HOME}/.bun/_bun"
    "${HOME}/.config/tabtab/zsh/__tabtab.zsh"
)

export DOT_BASH_COMPLETIONS=(
    "${HOME}"/.bash.d/*
    "${DOTFILES}"/config/bash/bash_completion.d/*
    /usr/local/Cellar/wp-cli-completion/2.8.1/etc/bash_completion.d/wp
)

export DOT_SOURCES=(
    "${ZDOTDIR}/auto-ls"
    "${HOME}/.cargo/env"
    "${HOME}/LS_COLORS/lscolors.sh"
)

export DOT_AFTER_INIT_SOURCES=(
    "${HOME}/.fzf.zsh"
    "${ZDOTDIR}/fzf"
    "${ZDOTDIR}/overrides"
    "${ZDOTDIR}/aliases"
)

export GPG_TTY=$(tty)

# Path
path=(
    /usr/local/sbin
    /usr/local/opt/openjdk/bin
    /usr/local/opt/openssl@1.1/bin
    "${HOME}/bin"
    "${HOME}/tools"
    "${HOME}/.composer/vendor/bin"
    "${HOME}/.bun/bin"
    "${HOME}/.yarn/bin"
    "${HOME}/.gem/ruby/2.6.0/bin"
    "${HOME}/tools/lua-language-server/bin/macOS"
    "${HOME}/.cargo/bin"
    "${HOME}/go/bin"
    "${HOME}/tools"
    "${path[@]}"
); typeset -aU path

#------------------------ Initialization - This is where most of the magic actually happens --------------------------#
source "${HOME}"/.cargo/env
source "${ZDOTDIR}"/init
#-------------------------------------------- Nice flashy intro graphics ---------------------------------------------#
lolmsg "$LOL_MSG" "$DOT_PROMPT_HEIGHT"
#--------------------------------------------- And finally, the prompt...---------------------------------------------#
safe_source "${ZDOTDIR}"/prompt/prompt
