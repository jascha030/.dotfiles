# Terminal / Dotfiles
alias x="exit"
alias c="clear"
alias checkitalics="echo -e '\e[3mitalic\e[23m'"
alias rr="source $HOME/.zshrc"
alias dfr="sh ${DOTFILES}/rcup"

# Navigation
alias ll="lsd -Ahl --color --group-dirs=first"
alias lc="ll | lolcat"
alias colorls="ll"
alias llb="ll | bat"
alias lr="colorls --tree=5"

# Editor Shortcuts 
alias vim="nvim"
alias edit="${EDITOR} $1"
alias pstorm="phpstorm ."
alias wstorm="webstorm ."
alias idea="idea ."
alias e:zshrc="edit $DOTFILES/zshrc"
alias e:zshrc="zshconfig"
alias e:aliases="edit ${HOME}/.aliases.zsh"
alias e:path="edit ${HOME}/.path.zsh"
alias create:wpindex="echo \"<?php\n//silence is golden\" >index.php"
alias create:gitignore="echo $'.idea\n\n.vscode\n\nvendor\n\n**.cache\n.DS_Store\n' > .gitignore"

# Directory Shortcuts
alias dev="cd ${HOME}/.development/Projects"
alias library="cd $HOME/Library"
alias dotfiles="cd ${DOTFILES}"
alias df="cd ${DOTFILES}"
alias web:sbcomposer="open https://composer.sbdev.nl/"

# Git Shortcuts
alias root=$(git rev-parse --show-toplevel)
alias kraken='$(open gitkraken://repo/$PWD)' # Note: Don't change to double quotes, as it auto-triggers.
alias clone:sb-starter="git clone git@bitbucket.org:socialbrothers/wordpress-starter-theme.git"
alias clone:wp="git clone git@github.com:wordpress/wordpress"

# Clipboard shortcuts
alias cp:dir="echo `echo $PWD` | pbcopy"
alias cp:ssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias cp:shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias cp:broodje="echo \"38. Witte Italiaanse Bol met Gerookte Kip, Avocado mayonaise met extra avocado en een blikkie cola. - €9,00\" | pbcopy"
alias cp:sbcrepo='echo "{\"type\": \"composer\", \"url\": \"https://composer.sbdev.nl/\"}" | pp_json | pbcopy'

# Utils
alias list:path=echo "$PATH" | tr ':' '\n'
alias scrsvr="open -a ScreenSaverEngine"
alias brewup="brew update && brew outdated; brew upgrade && brew cleanup; brew doctor"
alias tm-auto="sudo tmutil startbackup --auto; tmutil status"
alias cat="bat"
alias fpb="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias readme="bat ${PWD}/README.md"
alias luamake=/Users/jaschavanaalst/tools/lua-language-server/3rd/luamake/luamake

# PHP and Composer
alias "php7.4"="valet use php@7.4 && composer global update"
alias "php8.0"="valet use php@8.0 && composer global update"
alias "php8.1"="valet use php && composer global update"
alias php74="valet use php@7.4 && composer global update"
alias php8="valet use php@8.0 && composer global update"
alias php81="valet use php && composer global update"
alias c:pu="composer run phpunit"
alias c:pcs="composer run format"
alias c:reset="rm -rf vendor/ composer.lock && composer clear-cache && composer install"
alias valetrm="rm $HOME/.config/valet/valet.sock"
alias valetr="valetrm && valet restart"

# Suffix Aliases
alias -s php=pstorm
alias -s {.zshrc,zsh,sh,json,yaml,.env,cs,ts,html}=nvim

