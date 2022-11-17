# if (( ${+PROFILE_ZSHRC} )); then zmodload zsh/zprof; fi

# Hacky fix when first window of wezterm messes up lolmsg placement.
# Related to Hammerspoon handling of application on quake.
if (( ${LINES} == 24 )); then
    until (( ${LINES} > 24)); do exec zsh -l; done
fi

autoload -Uz compinit
setopt autocd extendedglob nomatch menucomplete
setopt traps_async
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=10,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=10'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=10,underline'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=10,bold'

export DOT_BASH_COMPLETIONS_DIRS=(
    ${HOME}/.bash.d
    /usr/local/Cellar/wp-cli-completion/2.6.0/etc
)

export DOT_COMP_DIRS=(
    ${HOME}/.bun/_bun
    ${HOME}/.config/tabtab/zsh/__tabtab.zsh
)

export DOT_SOURCES=(
    ${ZDOTDIR}/auto-ls
    ${HOME}/.cargo/env
    ${HOME}/LS_COLORS/lscolors.sh
)

export DOT_AFTER_INIT_SOURCES=(
    ${HOME}/.fzf.zsh
    ${ZDOTDIR}/fzf
    ${ZDOTDIR}/overrides
    ${ZDOTDIR}/aliases
)

# Path
path=(
    /usr/local/sbin
    /usr/local/opt/openjdk/bin
    /usr/local/opt/openssl@1.1/bin
    ${HOME}/bin
    ${HOME}/.composer/vendor/bin
    ${HOME}/.bun/bin
    ${HOME}/.yarn/bin
    ${HOME}/.gem/ruby/2.6.0/bin
    ${HOME}/tools/lua-language-server/bin/macOS
    ${HOME}/.cargo/bin
    ${HOME}/go/bin
    ${path[@]}
)

typeset -aU path

#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${ZDOTDIR}/init ]] && source ${ZDOTDIR}/init

compinit

safe_source ${ZDOTDIR}/prompt

lolmsg "$LOL_MSG" "$DOT_PROMPT_HEIGHT"

# if (( ${+PROFILE_ZSHRC} )); then echoti rmcup; echoti clear; echoti sgr0; zprof; unset PROFILE_ZSHRC; # fi
