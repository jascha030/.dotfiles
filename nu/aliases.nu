#!/usr/bin/env nu

alias rr = exec $env.SHELL -l
alias root = cd (git rev-parse --show-toplevel)
# alias kraken = (open gitkraken://repo/$env.PWD)

alias x = exit
alias c = clear
alias rd = rmdir
alias n = nvim
alias lg = lazygit

alias ll = ls -al
def lll [] { ll | lolcrab }
alias kk = ll
#
alias config = cd $env.XDG_CONFIG
alias cf = config
alias dev = cd $env.DEV
alias df = cd $env.DOTFILES
alias composerhome = cd (composer -g config home)

alias localenv = nvim $env.HOME/env.local
alias scrsvr = ^open -a ScreenSaverEngine
alias tm-auto = sudo tmutil startbackup --auto; tmutil status
def luamake [] { $env.HOME/tools/lua-language-server/3rd/luamake/luamake }

