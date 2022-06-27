export fpath=( ${fpath[@]} ${DOT_ZSH}/plugins/speedtest/functions )
autoload -Uz ${DOT_ZSH}/plugins/speedtest/functions/z_speedtest

function z_speedtest {
    # undefined
    builtin autoload -X
}

