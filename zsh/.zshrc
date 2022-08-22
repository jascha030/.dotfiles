#------------------------------------ Profile zshrc when enabled with $PROFILE_ZSH -----------------------------------#

if (( ${+PROFILE_ZSHRC} )); then zmodload zsh/zprof ;fi

# Hacky fix when first window of wezterm messes up lolmsg placement.
# Related to Hammerspoon handling of application on quake.
if (( ${LINES} == 24 )); then
  until (( ${LINES} > 24)); do exec zsh -l; done
fi

#------------------------------------------------ ZSH Configurations -------------------------------------------------#

setopt extended_glob
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export MANPAGER=/usr/local/bin/most
export LS_OVERRIDE='lsd'
export CAT_OVERRIDE='bat'
export LAZYGIT_CONFIG=${XDG_CONFIG}/lazygit
export FZF_DEFAULT_OPTS="--info=inline --border --padding=1 --margin=2"
export FPM_LOG=${XDG_CONFIG}/valet/Log/php-fpm.log
export BUN_INSTALL=${HOME}/.bun

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=10,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=10'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=10,underline'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=10,bold'

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
  ${path[@]}
)

typeset -aU path

#--------------------------------------------------------- FZF -------------------------------------------------------#

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}


export FZF_LIGHT=$FZF_DEFAULT_OPTS'
  --color=fg:#444a73,bg:#e7e9ef,hl:#5f5fec
  --color=fg+:#fffcfc,bg+:#c8d3f5,hl+:#0083f7
  --color=info:#6183bb,prompt:#ea1479,pointer:#ffcc00
  --color=marker:#ea1479,spinner:#5f5fec,header:#0083f7'

export FZF_DARK=$FZF_DEFAULT_OPTS'
  --color=fg:#c8d3f5,bg:#1e2030,hl:#5f5fec
  --color=fg+:#fffcfc,bg+:#32466e,hl+:#0083f7
  --color=info:#6183bb,prompt:#ea1479,pointer:#ffcc00
  --color=marker:#ea1479,spinner:#5f5fec,header:#465182'

#---------------------------------------------------- Init Exports ---------------------------------------------------#

export DOT_PROMPT_HEIGHT=4

export DOT_BASH_COMPLETIONS_DIRS=(
    ${HOME}/.bash.d
    /usr/local/Cellar/wp-cli-completion/2.6.0/etc
)

export DOT_COMP_DIRS=(
    ${HOME}/.bun/_bun
    ${HOME}/.config/tabtab/zsh/__tabtab.zsh
)

export DOT_SOURCES=(
    ${DOT_ZSH}/plugins/auto-ls
    ${HOME}/.cargo/env
    ${DOT_ZSH}/plugins/lolmsg/lolmsg.plugin.zsh
    ${HOME}/LS_COLORS/lscolors.sh
)

export DOT_AFTER_INIT_SOURCES=(
	${DOT_ZSH}/aliases
	${HOME}/.fzf.zsh
)

#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${DOT_ZSH}/init ]] && source ${DOT_ZSH}/init

#---------------------------------------------------------------------------------------------------------------------#

if (( ${+PROFILE_ZSHRC} )); then
  echoti rmcup; echoti clear; echoti sgr0; zprof unset PROFILE_ZSHRC
fi

