#!/usr/bin/env zsh

# -------- LAYOUT ELEMENTS --------- #

# Borders
# PS1_B(order)
export PS1_B_X='═'
export PS1_B_Y='║'
export PS1_B_TOP_L='╔'
export PS1_B_TOP_R='╗'
export PS1_B_BOT_R='╝'
export PS1_B_BOT_L='╚'

# Fill
# PS1_F(ill)C(haracter)
export PS1_FC="${PS1_B_X}"

# Height in lines
export PS1_HEIGHT=4

# PS1_L(eft)R(ight)_MARG(in) - Repeat $PS1_FC amt. of times.
export PS1_LR_MARG=${(pl.$(( ${#PS1_FC}*2 ))..$PS1_FC.)}

# PS1_[T(op)/B(ottom)][L(eft)/R(ight)].
export PS1_TL=' '${PS1_B_TOP_L}
export PS1_TR=${PS1_B_TOP_R}' '
export PS1_BL=' '${PS1_B_BOT_L}''${PS1_LR_MARG}
export PS1_BR=${PS1_LR_MARG}''${PS1_B_BOT_R}' '

export PROMPT_FUNCTIONS_PATH="${ZDOTDIR}/prompt/functions"

function prompt-length() {
    emulate -L zsh

    local -i COLUMNS=${2:-COLUMNS}

    local -i x y=${#1} m

    if (( y )); then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
            x=y
            (( y *= 2 ))
        done
        while (( y > x + 1 )); do
            (( m = x + (y - x) / 2 ))
            (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
    fi

    typeset -g REPLY=$x
}

function fill-line {
    emulate -L zsh

    if [ $# -eq 4 ]; then
        prompt-length $1 $4
    else
        prompt-length $1
    fi

    local -i left_len=REPLY

    prompt-length $2 9999
    local -i right_len=REPLY
    local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))

    local fill=${3:-${PS1_FC}}

    if (( pad_len < 1 )); then
        typeset -g REPLY=$1
    else
        local pad=${(pl.$pad_len..$fill.)}
        typeset -g REPLY=${1}${pad}${2}
    fi
}

function term-variable {
    emulate -L zsh

    local colored_output="${$(echo -n ${TERM} | lolcrab)[1,#TERM]}"
    typeset -g TERM_DISPLAY=$colored_output
}

function php-ver {
    emulate -L zsh

    if (( ${+PHP_VERSION} )); then
        local w=" %F{013}  ${PHP_VERSION}%f"
        typeset -g php_wgt=$w
    fi
}
