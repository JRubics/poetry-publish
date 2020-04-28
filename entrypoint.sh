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
poetry publish

