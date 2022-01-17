#!/usr/bin/env zsh
BATT_STAT_FULL=$(pmset -g batt | grep -Eo '\d{1,3}%')
BATT_STAT=${BATT_STAT_FULL[1,((${#BATT_STAT_FULL} - 1))]}

declare -A colors
colors=([21]="#ea1479" [61]="#ffcc00" [100]="#a2f100")

for i in 21 61 100; do
  if [ "$BATT_STAT" -lt "$i" ] && [ "${+BATT_STATUS_COLOR}" -eq 0 ]; then
    BATT_STATUS_COLOR="${colors[$i]}";
  fi
done;

echo "${BATT_STATUS_COLOR}"

