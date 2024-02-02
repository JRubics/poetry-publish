#!/bin/bash

set -e

cd ${13}

if [ -n "${11}" ]; then
  apt-get update
  apt-get -y upgrade
  apt-get -y install --no-install-recommends ${11}
fi

if [ $1 != 'latest' ]; then
  pyenv install $1
  pyenv global $1
  pyenv rehash
fi

if [ -z $8 ]; then
  pre=""
else
  pre="--pre"
fi

if [ $2 != 'latest' ]; then
  pip install poetry$2 $pre
else
  pip install poetry $pre
fi

if [ -n "${12}" ]; then
  poetry self add ${12}
fi

if [ -n "${7}" ]; then
  poetry install
else
  poetry install ${7}
fi

if [ -z $6 ]; then
  poetry build
else
  poetry build --format $6
fi

if [ -z $4 ] || [ -z $5 ]; then
  poetry config pypi-token.pypi $3
  poetry publish
else
  if [ -z $9 ] || [ -z ${10} ]; then
    poetry config pypi-token.$4 $3
    poetry config repositories.$4 $5
    poetry publish --repository $4
  else
    poetry config repositories.$4 $5
    poetry publish --repository $4 --username $9 --password ${10}
  fi
fi
