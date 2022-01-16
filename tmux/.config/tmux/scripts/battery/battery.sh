#!/usr/bin/env bash
pmset -g batt | grep -Eo '\d{1,3}%'
