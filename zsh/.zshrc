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
  ${path[@]}
)

typeset -aU path


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

#export MACOS_CURRENT_COLOR_SCHEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')


# bun completions
[ -s "/Users/jaschavanaalst/.bun/_bun" ] && source "/Users/jaschavanaalst/.bun/_bun"
