#!/usr/bin/env nu

alias rr = exec $env.SHELL -l
alias root = cd (git rev-parse --show-toplevel)

alias x = exit
alias c = clear
alias rd = rmdir
alias n = nvim
alias lg = lazygit

alias ll = ls -al
def lll [] { ll | lolcrab }
alias kk = ll

alias config = cd $env.XDG_CONFIG
alias cf = config
alias dev = cd $env.DEV
alias df = cd $env.DOTFILES
alias composerhome = cd (composer -g config home)

alias localenv = nvim $env.HOME/env.local
alias scrsvr = ^open -a ScreenSaverEngine
alias tm-auto = sudo tmutil startbackup --auto; tmutil status

def luamake [] { $env.HOME/tools/lua-language-server/3rd/luamake/luamake }

#alias kraken= ^open gitkraken://repo/${PWD}
#alias wpe='open "https://my.wpengine.com/#all"'

#alias brewup='brew update && brew outdated; brew upgrade && brew cleanup; brew doctor'
#alias cargoup='cargo install-update --all'
#alias appup='brewup && cargoup'

#alias valetrm='rm ${HOME}/.config/valet/*.sock'
#alias valetr='valetrm && valet restart'
#alias vo='valet open'

#alias xdebug:enable="export XDEBUG_MODE=debug XDEBUG_SESSION=1"

