#------------------------------------ Profile zshrc when enabled with $PROFILE_ZSH -----------------------------------#

if (( ${+PROFILE_ZSHRC} )); then zmodload zsh/zprof ;fi

# Hacky fix when first window of wezterm messes up lolmsg placement.
# Related to Hammerspoon handling of application on quake.
if (( ${LINES} == 24 )); then
  until (( ${LINES} > 24)); do exec zsh -l; done
fi

#------------------------------------------------ ZSH Configurations -------------------------------------------------#

setopt extended_glob
setopt traps_async
setopt nohup
unsetopt BEEP

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#A59BFF,bg=#033E5D,bold,underline"
export MANPAGER=/usr/local/bin/most
export LS_OVERRIDE='lsd'
export CAT_OVERRIDE='bat'
export LAZYGIT_CONFIG=${XDG_CONFIG}/lazygit
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
    ${ZDOTDIR}/auto-ls
    ${HOME}/.cargo/env
    ${HOME}/LS_COLORS/lscolors.sh
    ${ZDOTDIR}/plugins/lolmsg/lolmsg.plugin.zsh
)

export DOT_AFTER_INIT_SOURCES=(
  ${ZDOTDIR}/overrides
	${ZDOTDIR}/aliases
	${HOME}/.fzf.zsh
  ${ZDOTDIR}/fzf
)

#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${ZDOTDIR}/init ]] && source ${ZDOTDIR}/init

#---------------------------------------------------------------------------------------------------------------------#

if (( ${+PROFILE_ZSHRC} )); then
  echoti rmcup; echoti clear; echoti sgr0; zprof unset PROFILE_ZSHRC
fi

