# Ali(J)asses

# Terminal / general
alias x="exit"
alias c="clear"

# Dotfiles related
alias rr="source $HOME/.zshrc"
alias dfr="sh ${DOTFILES}/rcup"

# Edit shortcuts
alias edit="${EDITOR} $1"
alias zshconfig="edit $DOTFILES/zsh/.zshrc"
alias e:zshrc="zshconfig"
alias e:aliases="edit ${HOME}/.aliases.zsh"
alias e:path="edit ${HOME}/.path.zsh"

# Navigation
alias ll="lsd -Ahl --color --group-dirs=first"
alias lc="ll | lolcat"
alias colorls="ll"
alias llb="ll | bat"
alias lr="colorls --tree=5"

# Shortcuts to dirs
alias dotfiles="cd ${DOTFILES}"
alias df="cd ${DOTFILES}"
alias df:nvim="cd ${DOTFILES}/nvim/.config/nvim"
alias df:tmux="cd ${DOTFILES}/tmux/.config/tmux"
alias df:util="cd ${DOTFILES}/util"
alias df:zsh="cd ${DOTFILES}/zsh"
alias df:alacritty="cd ${DOTFILES}/alacritty/.config/alacritty"

# Navigate to git root
alias root=$(git rev-parse --show-toplevel)
alias g:root=root
alias grr=root

alias web:sbcomposer="open https://composer.sbdev.nl/"

# Utils

# Copy Broodje Ben to clipboard.
alias cpbroodje="echo \"38. Witte Italiaanse Bol met Gerookte Kip, Avocado mayonaise met extra avocado en een blikkie cola. - €8,75\" | pbcopy"

# Start screensaver
alias scrsvr="open -a ScreenSaverEngine"

# Bat instead of cat
alias cat="bat"
alias ogcat="\cat"
alias fpb="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias readme="bat ${PWD}/README.md"

# Clean and update Brew
alias brewup="brew update && brew outdated; brew upgrade && brew cleanup; brew doctor"

# Faster Time Machine Backup
alias tm-auto="sudo tmutil startbackup --auto; tmutil status"

# Remove valet.sock and restart.
alias valetrm="rm $HOME/.config/valet/valet.sock"
alias valetr="valetrm && valet restart" # Make a symbolic link in current dir.

# Switch php versions
alias "php7.4"="valet use php@7.4 && composer global update"
alias "php8.0"="valet use php@8.0 && composer global update"
alias "php8.1"="valet use php && composer global update"
alias php74="valet use php@7.4 && composer global update"
alias php8="valet use php@8.0 && composer global update"
alias php81="valet use php && composer global update"


# Chrome with just a little bit less RAMpage.
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --process-per-site"
alias browser="chrome"
alias chromi="chrome -incognito"

# Open current dir in...
alias kraken='$(open gitkraken://repo/$PWD)' # Gitkraken

alias pstorm="phpstorm ." # Phpstorm
alias wstorm="webstorm ." # Webstorm
alias idea="idea ."       # Intellij IDEA

# Working dirs
alias dev="cd ${HOME}/.development/Projects"
alias library="cd $HOME/Library"

alias cache:spotify="cd ${HOME}/Library/Application Support/spotify"

# Start composer project start-composerpr
alias cmprj="start-composerpr"

alias c:pu="composer run phpunit"
alias c:pcs="composer run format"

# Suffix Aliases
alias -s php=pstorm
alias -s {.zshrc,zsh,sh,json,yaml,.env,cs,ts,html}=nvim

# Templates
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias cpssh="copyssh"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias ccdir="echo `echo $PWD` | pbcopy"

alias c:wpindex="echo \"<?php\n//silence is golden\" >index.php"
alias dfile:.gitignore="echo $'.idea\n\n.vscode\n\nvendor\n\n**.cache\n.DS_Store\n' > .gitignore"
alias sbcrepo='echo "{\"type\": \"composer\", \"url\": \"https://composer.sbdev.nl/\"}" | pp_json | pbcopy'

# Wordpress related aliases
alias clone:sb-starter="git clone git@bitbucket.org:socialbrothers/wordpress-starter-theme.git"
alias clone:wp="git clone git@github.com:wordpress/wordpress"

alias vim="nvim"
alias composerreset="rm -rf vendor/ composer.lock && composer clear-cache && composer install"
alias checkitalics="echo -e '\e[3mitalic\e[23m'"

alias sbcrepo='echo "{\"type\": \"composer\", \"url\": \"https://composer.sbdev.nl/\"}" | pp_json | pbcopy'

alias luamake=/Users/jaschavanaalst/tools/lua-language-server/3rd/luamake/luamake

# Logging with bat
alias batlog="echo 'TODA BATLOG PUDULULULULUDUDULU'; bat --paging=never -l log"

