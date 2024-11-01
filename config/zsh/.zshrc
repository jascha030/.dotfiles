#!/usr/bin/env zsh

# shellcheck disable=SC2093,SC1091,SC2155

#- Logic required to easily toggle between zprof profiling -----------------------------------------------------------#
[ ! -f "${HOME}/.zprofrc" ] && echo 'export ZPROF_ENABLED=0' > ${HOME}/.zprofrc
source ${HOME}/.zprofrc

if [[ "$ZPROF_ENABLED" -eq 1 ]]; then
    zmodload zsh/zprof
fi

#- FIX: If term is not nvim, apply Hacky fix when first window of wezterm messes up lolmsg placement.-----------------#
if ! (( ${+VIM} && ${+VIMRUNTIME} && ${+MYVIMRC} )); then
    [[ "$TERM_PROGRAM" == "WezTerm" ]] && (( LINES == 24 )) && { until (( LINES > 24 )); do exec zsh -l; done; }
fi

#- Dotfiles start here. ----------------------------------------------------------------------------------------------#

setopt autocd extendedglob nomatch menucomplete traps_async
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:git-checkout:*' sort false                                # disable sort on `git checkout`
zstyle ':completion:*:descriptions' format '[%d]'                               # set descr fmt to enable group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                           # set enable filename colorizing
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'   # preview dir content with exa for cd
zstyle ':fzf-tab:*' switch-group ',' '.'                                        # switch group using `,` and `.`

export ZSH_HIGHLIGHT_STYLES
typeset -A ZSH_HIGHLIGHT_STYLES=(
    autodirectory   'fg=10,underline'
    arg0            'fg=10'
    suffix-alias    'fg=10,underline'
    bracket-level-2 'fg=10,bold'
)

export DOT_COMP_DIRS=(
    ${HOME}/.bun
    ${HOME}/.config/tabtab/zsh
    ${HOME}/tools/eza/completions/zsh
)

export DOT_BASH_COMPLETIONS=(
    ${HOME}/.bash.d/*
    ${DOTFILES}/config/bash/bash_completion.d/*
    /opt/homebrew/Cellar/wp-cli-completion/**/etc/bash_completion.d/*
)

export DOT_SOURCES=(
    ${ZDOTDIR}/auto-ls
    ${HOME}/.cargo/env
    ${HOME}/LS_COLORS/lscolors.sh
)

export DOT_AFTER_INIT_SOURCES=(
    ${ZDOTDIR}/.ls-colors
    /opt/homebrew/etc/grc.zsh
    ${ZDOTDIR}/overrides
    ${ZDOTDIR}/fzf
    ${HOME}/.bun/_bun
    ${HOME}"/env.local"
)

BREW_HOME=/opt/homebrew/opt
export HOMEBREW_NO_INSTALL_FROM_API=1

path=(
    ${BREW_HOME}/ncurses/bin
    ${BREW_HOME}/gnu-sed/libexec/gnubin
    ${BREW_HOME}/openjdk/bin
    ${BREW_HOME}/openssl@1.1/bin
    ${XDG_CONFIG_HOME}/bash/bin
    ${XDG_CONFIG_HOME}/zsh/bin
    ${HOME}/bin
    ${HOME}/tools
    ${HOME}/.composer/vendor/bin
    ${HOME}/.bun/bin
    ${HOME}/.yarn/bin
    ${HOME}/.gem/ruby/2.6.0/bin
    ${HOME}/.cargo/bin
    ${HOME}/go/bin
    ${HOME}/tools
    ${HOME}/.local/share/rtx/shims
    ${HOME}/.local/share/nvim/mason/bin
    ${HOME}/.development/Projects/Php/Wordpress/vip/allegion-cli/bin
    ${path[@]}
); typeset -aU path

[[ ! -r "$HOME"/.opam/opam-init/init.zsh ]] || source "$HOME"/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

#- Initialization - This is where most of the magic actually happens -------------------------------------------------#
source ${ZDOTDIR}/init

if [[ "$ZPROF_ENABLED" -eq 1 ]]; then
    zprof
fi

# bun completions
[ -s "/Users/jaschavanaalst/.bun/_bun" ] && source "/Users/jaschavanaalst/.bun/_bun"
