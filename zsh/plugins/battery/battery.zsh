#!/usr/bin/env zsh

BATT_STAT_FULL=$(pmset -g batt | grep -Eo '\d{1,3}%')
BATT_STAT=${BATT_STAT_FULL[1,((${#BATT_STAT_FULL} - 1))]}

typeset -A icons
icons=([10]="" [20]="" [30]="" [40]="" [50]="" [60]="" [70]="" [80]="" [90]="" [90]="" [100]="")
i=10

while [ "$BATT_STAT" -gt $i ]; do i=$((i+10)); done;
BATT_ICON="${icons[$i]}";

echo "${BATT_ICON} ${BATT_STAT}%"
