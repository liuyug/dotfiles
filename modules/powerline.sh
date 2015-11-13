#!/bin/bash

set -e

if [ ! -d "$(pwd)/powerline" ]; then
    mkdir -p powerline
fi

(cd powerline; git clone https://github.com/Lokaltog/powerline)
(cd powerline/powerline; python setup.py install --user)
(cd powerline/powerline/font; cp PowerlineSymbols.otf $HOME/.fonts)
# (cd powerline; git clone https://github.com/powerline/fonts)
# (cd powerline/fonts; bash install.sh)

fc-cache -vf
