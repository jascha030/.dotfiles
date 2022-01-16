#!/usr/bin/env bash
BATT_STAT=$(pmset -g batt | grep -Eo '\d{1,3}%' | cut -c -3)

if (($BATT_STAT < 10)); then
  BATT_ICON=""
elif (($BATT_STAT < 20)); then
  BATT_ICON=""
elif (($BATT_STAT < 30)); then
  BATT_ICON=""
elif (($BATT_STAT < 40)); then
  BATT_ICON=""
elif (($BATT_STAT < 50)); then
  BATT_ICON=""
elif (($BATT_STAT < 60)); then
  BATT_ICON=""
elif (($BATT_STAT < 70)); then
  BATT_ICON=""
elif (($BATT_STAT < 80)); then
  BATT_ICON=""
elif (($BATT_STAT < 90)); then
  BATT_ICON=""
else
  BATT_ICON=""
fi

echo "$BATT_ICON $BATT_STAT%"

