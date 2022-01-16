#!/usr/bin/env bash
BATTERY_PERCENTAGE=$(pmset -g batt | grep -Eo '\d{1,3}%' | cut -c -3)

if (($BATTERY_PERCENTAGE < 21)); then
  BATT_STATUS_COLOR="#ea1479"
elif (($BATTERY_PERCENTAGE < 61)); then
  BATT_STATUS_COLOR="#ffcc00"
else  
  BATT_STATUS_COLOR="#a2f100"
fi

echo $BATT_STATUS_COLOR

