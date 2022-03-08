#!/usr/bin/env zsh
PHP=$(which php)
PHP_VERSION=$($PHP -r 'echo PHP_VERSION;')
PHP_VERSION=${PHP_VERSION[1,3]}

echo " ${PHP_VERSION}"

