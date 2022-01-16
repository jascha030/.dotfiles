#!/usr/bin/env bash
BATT_STAT_FULL=$(pmset -g batt | grep -Eo "\d{1,3}%")
BATT_STAT=${BATT_STAT_FULL%?}

if (($BATT_STAT < 21)); then
  BATT_STATUS_COLOR="#ea1479"
elif (($BATT_STAT < 61)); then
  BATT_STATUS_COLOR="#ffcc00"
else  
  BATT_STATUS_COLOR="#a2f100"
fi

echo $BATT_STATUS_COLOR

