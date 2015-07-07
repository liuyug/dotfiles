#!/bin/sh


if [ -d "$(pwd)/powerline" ]; then
    mkdir -p powerline
fi

(cd powerline; git clone https://github.com/Lokaltog/powerline)
(cd powerline/powerline; python setup.py install --user)
(cd powerline/powerline/font; cp PowerlineSymbols.otf $HOME/.fonts)
# (cd powerline; git clone https://github.com/powerline/fonts)
# (cd powerline/fonts; bash install.sh)

fc-cache -vf

# powerline config files
mkdir -p $HOME/.config/powerline
cp -r powerline/powerline/config_files/* $HOME/.config/powerline/
