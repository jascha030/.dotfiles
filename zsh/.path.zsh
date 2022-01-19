# SBIN
export PATH="/usr/local/sbin:$PATH"

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Ruby
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# PyEnv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

# User bin
export PATH="${HOME}/bin:${PATH}"

# OpenJDK
export PATH="/usr/local/opt/openjdk/bin:${PATH}"

# Openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# Lua language server
export PATH="$HOME/tools/lua-language-server/bin/macOS:$PATH"


# Lolcat
LOLCAT=$(which lolcat)
export PATH="${LOLCAT}:${PATH}"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

