# Reset blink effect in case it wasn't ended in previous session.
if ! (( ${+DOT_DEFAULT_LOL_MSG} )); then 
    # Normal msg displayed with figlet in funky colors.
    export DOT_DEFAULT_LOL_MSG="Hackerman Mode 030"   
fi 

if ! (( ${+DOT_NEOVIM_LOL_MSG} )); then 
    # Alt msg displayed when in Neovim term.
    export DOT_NEOVIM_LOL_MSG="NVIM 030"
fi

export fpath=( ${fpath[@]} ${DOT_ZSH}/plugins/lolmsg )

autoload -Uz ${DOT_ZSH}/plugins/lolmsg/lolmsg

function lolmsg {
    # undefined
    builtin autoload -X
}

