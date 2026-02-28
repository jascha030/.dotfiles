#!/usr/bin/env zsh

# shellcheck disable=SC2093,SC1091,SC2155

#- Logic required to easily toggle between zprof profiling -----------------------------------------------------------#
[[ -f ${HOME}/.zprofrc ]] || print -r -- 'export ZPROF_ENABLED=0' > ${HOME}/.zprofrc
source ${HOME}/.zprofrc

if (( ZPROF_ENABLED )); then
    zmodload zsh/zprof
fi

#- Logic required to easily toggle per-command timing ----------------------------------------------------------------#
[[ -f ${HOME}/.ztimingrc ]] || print -r -- 'export DOT_TIMING_ENABLED=0' > ${HOME}/.ztimingrc
source ${HOME}/.ztimingrc

if (( DOT_TIMING_ENABLED )); then
    zmodload zsh/datetime
fi

#- Dotfiles start here. ----------------------------------------------------------------------------------------------#

setopt autocd extendedglob nomatch menucomplete traps_async
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                           # set enable filename colorizing
zstyle ':completion:*' menu no                                                  # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'   # preview dir content with exa for cd
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2                                # --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes                                    # To make fzf-tab follow FZF_DEFAULT_OPTS.
zstyle ':fzf-tab:*' switch-group '[' ']'

export ZSH_HIGHLIGHT_STYLES
typeset -A ZSH_HIGHLIGHT_STYLES=(
    autodirectory   'fg=10,underline'
    arg0            'fg=10'
    suffix-alias    'fg=10,underline'
    bracket-level-2 'fg=10,bold'
)

export DOT_REQUIRED_DIRS=(
    ${DOT_DATA_DIR:-${XDG_CONFIG_HOME}/datafiles}
)

export DOT_REQUIRED_FILES=(
    ${DOT_DATA_DIR:-${XDG_CONFIG_HOME}/datafiles}/.zsh_history
    ${DOT_DATA_DIR:-${XDG_CONFIG_HOME}/datafiles}/.mysql_history
)

export DOT_COMP_DIRS=(
    ${HOME}/.bun
    ${HOME}/tools/eza/completions/zsh
    ${XDG_CONFIG_HOME}/tabtab/zsh
    ${ZDOTDIR}/completions
    /opt/homebrew/share/zsh/site-functions
)

export DOT_BASH_COMPLETIONS=(
    # ${HOME}/.bash.d/*
    ${DOTFILES}/config/bash/bash_completion.d/*
    /opt/homebrew/Cellar/wp-cli-completion/**/etc/bash_completion.d/*
)

export DOT_SOURCES=(
    ${ZDOTDIR}/auto-ls
    ${HOME}/.cargo/env
    ${HOME}/.development/LS_COLORS/lscolors.sh
)

export DOT_AFTER_INIT_SOURCES=(
    ${ZDOTDIR}/.ls-colors
    ${ZDOTDIR}/overrides
    ${ZDOTDIR}/fzf
    ${HOME}/env.local
)

export DOT_PATH_VAR=(
    ${BREW_HOME}/ncurses/bin
    ${BREW_HOME}/gnu-sed/libexec/gnubin
    ${BREW_HOME}/openjdk/bin
    ${BREW_HOME}/openssl@1.1/bin
    ${XDG_CONFIG_HOME}/bash/bin
    ${XDG_CONFIG_HOME}/zsh/bin
    ${HOME}/bin
    ${HOME}/tools
    ${HOME}/.bun/bin
    ${HOME}/.gem/ruby/2.6.0/bin
    ${HOME}/.cargo/bin
    ${HOME}/go/bin
    ${HOME}/.local/share/rtx/shims
    ${HOME}/.local/share/nvim/mason/bin
    ${HOME}/.local/bin
    /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp
)

typeset -ga _DOT_ZCOMP_FILES=(
  ${ZDOTDIR}/init
  ${ZDOTDIR}/lazyfunctions
  ${ZDOTDIR}/overrides
  ${ZDOTDIR}/plugins-spec
)

__conditional_zcompile() {
    local file zwc
    for file in "$@"; do
        zwc="${file}.zwc"

        if [[ ! -f "$zwc" || "$file" -nt "$zwc" || "$zwc"(#qN.mh+24) ]]; then
            zcompile "$file"
        fi
    done
}

__conditional_zcompile "${_DOT_ZCOMP_FILES[@]}"
unfunction __conditional_zcompile

[[ -r ${HOME}/.opam/opam-init/init.zsh ]] && source ${HOME}/.opam/opam-init/init.zsh &>/dev/null

#- Initialization - This is where most of the magic actually happens -------------------------------------------------#
source ${ZDOTDIR}/init

if (( ZPROF_ENABLED )); then
    zprof
fi

#- Per-command timing instrumentation (must be last to wrap all hooks) ------------------------------------------------#
source ${ZDOTDIR}/timing
