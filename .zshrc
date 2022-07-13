#------------------------------------ Profile zshrc when enabled with $PROFILE_ZSH -----------------------------------#

if (( ${+PROFILE_ZSHRC} )); then zmodload zsh/zprof ;fi

#------------------------------------------------ ZSH Configurations -------------------------------------------------#

# Hacky fix when first window of wezterm messes up lolmsg placement.
# Related to Hammerspoon handling of application on quake.
if (( ${LINES} == 24 )); then 
  until (( ${LINES} > 24)); do exec zsh -l; done
fi

setopt extended_glob
unsetopt BEEP

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
  ${path[@]}
)

typeset -aU path

export DOT_PROMPT_HEIGHT=4

export DOT_COMP_DIRS=(
    ${HOME}/.bun/_bun
    ${HOME}/.config/tabtab/zsh/__tabtab.zsh
)

export DOT_SOURCES=( 
    ${DOT_ZSH}/plugins/auto-ls
    ${HOME}/.cargo/env
    ${DOT_ZSH}/plugins/lolmsg/lolmsg.plugin.zsh
)

export DOT_AFTER_INIT_SOURCES=( ${DOT_ZSH}/aliases ${HOME}/.fzf.zsh )


#------------------------------------------------- Initialization ----------------------------------------------------#

[[ -f ${DOT_ZSH}/init ]] && source ${DOT_ZSH}/init

#---------------------------------------------------------------------------------------------------------------------#

if (( ${+PROFILE_ZSHRC} )); then 
  echoti rmcup; echoti clear; echoti sgr0; zprof unset PROFILE_ZSHRC
fi

