#!/bin/bash

set -e

if [ $1 != 'latest' ]; then
  pyenv latest install $1
  pyenv latest global $1
  pyenv rehash
fi

if [ $2 != 'latest' ]; then
  pip install poetry$2
else
  pip install poetry
fi

poetry build
poetry config pypi-token.pypi $3
if [ -z $4 ] || [ -z $5 ]; then
  poetry publish
else
  poetry config pypi-token.$4 $3
  poetry config repositories.$4 $5
  poetry publish --repository $4
fi
