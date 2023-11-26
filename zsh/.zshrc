#!/usr/bin/env zsh

# shellcheck disable=SC2093,SC1091,SC2155
if [[ "$ZPROF_ENABLED" -eq 1 ]]; then
    zmodload zsh/zprof
fi

# Conditional, if current term is not nvim, apply Hacky fix when first window of wezterm messes up lolmsg placement.
if ! (( ${+VIM} && ${+VIMRUNTIME} && ${+MYVIMRC} )); then
    [[ "$TERM_PROGRAM" == "WezTerm" ]] && (( LINES == 24 )) && { until (( LINES > 24 )); do exec zsh -l; done; }
fi

typeset -A ZSH_HIGHLIGHT_STYLES=(
    autodirectory   'fg=10,underline'
    arg0            'fg=10'
    suffix-alias    'fg=10,underline'
    bracket-level-2 'fg=10,bold'
)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

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
    "$ZDOTDIR/colors.zsh"
    "${ZDOTDIR}/fzf"
    "${ZDOTDIR}/overrides"
    "${ZDOTDIR}/aliases"
)

[[ ! -r "$HOME"/.opam/opam-init/init.zsh ]] \
    || source "$HOME"/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


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
eval "$(/opt/homebrew/bin/brew shellenv)"
source "${ZDOTDIR}"/init

#-------------------------------------------- Nice flashy intro graphics ---------------------------------------------#
[ -f "${HOME}/.lolmsgrc" ] && . "${HOME}/.lolmsgrc" || echo 'export LOLMSGRC_ENABLED=1' > "${HOME}/.lolmsgrc"
[ -f "${HOME}/.zprofrc" ] && . "${HOME}/.zprofrc" || echo 'export ZPROF_ENABLED=1' > "${HOME}/.zprofrc"

function __toggle_zprof() {
    if [[ "$ZPROF_ENABLED" -eq 0 ]]; then
        echo 'export ZPROF_ENABLED=1' > "${HOME}/.zprofrc"
        echo 'zprof enabled'
    fi

    if [[ "$ZPROF_ENABLED" -eq 1 ]]; then
        echo 'export ZPROF_ENABLED=0' > "${HOME}/.zprofrc"
        echo 'zprof disabled'
    fi
}

function __toggle_lolmsg_rc() {
    if [[ "$LOLMSGRC_ENABLED" -eq 0 ]]; then
        echo 'export LOLMSGRC_ENABLED=1' > "${HOME}/.lolmsgrc"
        echo 'lolmsg enabled'
    fi

    if [[ "$LOLMSGRC_ENABLED" -eq 1 ]]; then
        echo 'export LOLMSGRC_ENABLED=0' > "${HOME}/.lolmsgrc"
        echo 'lolmsg disabled'
    fi
}

alias toggle-lolmsg='__toggle_lolmsg_rc'
alias toggle-zprof='__toggle_zprof'

[[ "$LOLMSGRC_ENABLED" -eq 1 ]] && lolmsg "$LOL_MSG" "$DOT_PROMPT_HEIGHT"

#--------------------------------------------- And finally, the prompt...---------------------------------------------#
safe_source "${ZDOTDIR}"/prompt/prompt
eval "$(mcfly init zsh)" # Init mcfly last.

[[ "$ZPROF_ENABLED" -eq 1 ]] && zprof
