#!/usr/bin/env zsh
BATT_STAT_FULL=$(pmset -g batt | grep -Eo '\d{1,3}%')
BATT_STAT=${BATT_STAT_FULL[1,((${#BATT_STAT_FULL} - 1))]}

typeset -A colors
colors=([21]="#ea1479" [61]="#ffcc00" [101]="#a2f100")

for i in 21 61 101; do
  if [ "$((BATT_STAT))"  -lt "$i" ] && [ -z ${BATT_STATUS_COLOR+x} ]; then
    BATT_STATUS_COLOR="${colors[$i]}";
  fi
done;

echo "${BATT_STATUS_COLOR}"

