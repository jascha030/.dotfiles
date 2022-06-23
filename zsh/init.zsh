#######################################################################################################################
#                                               Dotfiles Initialization                                               #
# By Jascha030                                                                  https://github.io/jascha030/.dotfiles #
#######################################################################################################################

# Default antigen.zsh path.
# Based on a normal install, overwrite if installed through brew.
if ! (( ${+DOT_ANTIGEN_PATH} )); then 
    export DOT_ANTIGEN_PATH="${HOME}/antigen.zsh"
fi

# Left rc path open to edit, allthough Antigen acts weird when rc not @ $HOME.
if ! (( ${+DOT_ANTIGEN_RC_PATH} )); then 
    export DOT_ANTIGEN_RC_PATH="${HOME}/.antigenrc"
fi

# Autoload all files in dir.
function __autoload_dirs {
    local a
    
    for a in "$@"; do
        if [[ -f "$a" ]]; then 
            echo $a
            autoload -Uz "$a"
        fi 

        if [[ -d "$a" ]]; then 
            autoload -Uz ${a}/*(.:t)
        fi
    done
}

# Load antigen plugins.
function __df_load_antigen {
    # Todo: check
    if [[ ! -f "$DOT_ANTIGEN_PATH" ]]; then 
        curl -L git.io/antigen > $DOT_ANTIGEN_PATH
    fi
  
    source "$DOT_ANTIGEN_PATH"

    if [[ -f "$DOT_ANTIGEN_RC_PATH" ]]; then 
        antigen init "$DOT_ANTIGEN_RC_PATH"
    fi
}


# Dotfiles zsh function root dir.
export DOT_ZFUNC="${DOT_ZSH}/zfunc"


# Default directory for functions.
# Add by exporting (array) `DOT_AUTOLOAD_DIRS`.
local AUTOLOAD_DIRS=( "${DOT_ZFUNC}" )

# Merge defaults with user defined.
if (( ${+DOT_AUTOLOAD_DIRS} )); then 
    $AUTOLOAD_DIRS+=( ${DOT_AUTOLOAD_DIRS[@]} )
fi 

# Default directory for completions.
# Add by exporting (array) `DOT_COMP_DIRS`.
local COMP_DIRS=( "${DOT_ZFUNC}/completions" )

# Files to be sourced before the ones added in `.zshrc`.
local _SOURCES=( "${DOT_ZSH}/path" )

# Add lazyload dirs to fpath.
fpath=("${fpath[@]}" "${AUTOLOAD_DIRS[@]}")

# Pre autoload (defined lazily velow).
__autoload_dirs "${AUTOLOAD_DIRS}"

# Source path file.
safe_source "${_SOURCES[@]}"

typeset -aU path

# Source other zsh dotfiles
if (( ${+DOT_SOURCES} )); then 
    safe_source "${DOT_SOURCES[@]}"
fi

# Lazy load functions that are only used conditionally.
# All functions reside in the default functions dir.

# Checks if directories or creates them using `mkdir -p`.
function assert_dirs {
    # undefined 
    builtin autoload -X
}

# Checks if files exist or creates them using `touch`.
function assert_files {
    # undefined 
    builtin autoload -X
}

# Utility function, to merge arrays...
function merge_arrays {
    # undefined 
    builtin autoload -X
}

# Display msg after load.
function lolmsg {
    # undefined
    builtin autoload -X
}

# Loads files in default $DOT_ZSH_DIR.
# Define by exporting (array) $DOT_ZSH_SOURCES.
function source_zsh_dotfiles {
    # undefined 
    builtin autoload -X
}

# Executes eval on provided statements.
function exec_evaluations {
    # undefined 
    builtin autoload -X
}


# Bootstrap required dirs and files
if (( ${+DOT_REQUIRED_DIRS} )); then 
    assert_dirs "${DOT_REQUIRED_DIRS[@]}"
fi

if (( ${+DOT_REQUIRED_FILES} )); then
    assert_files "${DOT_REQUIRED_FILES[@]}"
fi

# Source other zsh dotfiles
if (( ${+DOT_SOURCES} )); then 
    safe_source "${DOT_SOURCES[@]}"
fi

if (( ${+DOT_COMP_DIRS} )); then 
    COMP_DIRS+=( "${DOT_COMP_DIRS[@]}" )
fi

# Set $fpath
export fpath=( "${fpath[@]}" "${COMP_DIRS[@]}" )

# Load completions.
__autoload_dirs "${COMP_DIRS[@]}"
    
# Load antigen plugins.
__df_load_antigen

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(teleport-dir init)"
eval "$(fnm env)"
    
# Source other zsh dotfiles
if (( ${+DOT_ZSH_SOURCES} )); then 
    source_zsh_dotfiles "${DOT_ZSH_SOURCES[@]}"
fi


# Allow to turn off lolmsg when debugging.
if ! (( ${+DOT_DISABLE_MSG} )); then 
    lolmsg "${VIM_TERM_MODE_ACTIVE}" "${DOT_DEFAULT_LOL_MSG}" "${DOT_NEOVIM_LOL_MSG}"
fi

