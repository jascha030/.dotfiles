#!/usr/bin/env zsh
PHP=$(which php)
PHP_VERSION=$($PHP -r 'echo PHP_VERSION;')

echo " ${PHP_VERSION}"

