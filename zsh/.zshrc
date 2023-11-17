#!/usr/bin/env zsh

# shellcheck disable=SC2093,SC1091,SC2155

# Conditionals, if current term is not in neovim .
if ! (( ${+VIM} && ${+VIMRUNTIME} && ${+MYVIMRC} )); then
    # Hacky fix when first window of wezterm messes up lolmsg placement.
    [[ "$TERM_PROGRAM" == "WezTerm" ]] && (( LINES == 24 )) && { until (( LINES > 24 )); do exec zsh -l; done; }
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
typeset -A ZSH_HIGHLIGHT_STYLES=(autodirectory 'fg=10,underline' arg0 'fg=10' suffix-alias 'fg=10,underline' bracket-level-2 'fg=10,bold')
setopt autocd extendedglob nomatch menucomplete traps_async
unsetopt BEEP

eval "$(/opt/homebrew/bin/brew shellenv)"

export DOT_COMP_DIRS=(
    "${HOME}/.bun/_bun"
    "${HOME}/.config/tabtab/zsh/__tabtab.zsh"
)

export DOT_BASH_COMPLETIONS=(
    "${HOME}"/.bash.d/*
    "${DOTFILES}"/config/bash/bash_completion.d/*
    /opt/homebrew/Cellar/wp-cli-completion/**/etc/bash_completion.d/*
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

[[ ! -r /Users/jaschavanaalst/.opam/opam-init/init.zsh ]] \
    || source /Users/jaschavanaalst/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


# Path
path=(
    /opt/homebrew/opt/gnu-sed/libexec/gnubin
    /opt/homebrew/opt/openjdk/bin
    /opt/homebrew/opt/openssl@1.1/bin
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
    "${HOME}/.local/share/rtx/shims"
    "${path[@]}"
); typeset -aU path

#------------------------ Initialization - This is where most of the magic actually happens --------------------------#
source "${HOME}"/.cargo/env
source "${ZDOTDIR}"/init
#-------------------------------------------- Nice flashy intro graphics ---------------------------------------------#
lolmsg "$LOL_MSG" "$DOT_PROMPT_HEIGHT"
#--------------------------------------------- And finally, the prompt...---------------------------------------------#
safe_source "${ZDOTDIR}"/prompt/prompt
# Init mcfly last.
eval "$(mcfly init zsh)"
