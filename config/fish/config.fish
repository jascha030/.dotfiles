# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
#                                 ><^o *blub blup boop* o^><
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

set -g DOTFILES $HOME/.dotfiles
set -g XDG_CONFIG $HOME/.config
set -g DOT_RC $XDG_CONFIG/fish/config.fish  

set -U EDITOR nvim
set -U LAZYGIT_CONFIG $XDG_CONFIG/lazygit/config.yml 

set -U fish_user_paths /usr/local/sbin \
                       /usr/local/opt/openjdk/bin \
                       /usr/local/opt/openssl@1.1/bin \
                       node_modules/.bin \
                       vendor/bin \
                       $HOME/bin \
                       $HOME/.composer/vendor/bin \
                       $HOME/.node/bin \
                       $HOME/.yarn/bin  \
                       $HOME/.config/yarn/global/node_modules/.bin \
                       $HOME/.gem/ruby/2.6.0/bin \
                       $HOME/tools/lua-language-server/bin/macOS

if status is-interactive
    set -U EDITOR nvim
    set -U LAZYGIT_CONFIG $XDG_CONFIG/lazygit/config.yml 

    source $DOTFILES/aliases
    
    starship init fish | source
end
