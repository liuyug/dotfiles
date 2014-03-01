#!/bin/sh


if [ -d "$(pwd)/powerline" ]; then
    (cd powerline; git pull)
else
    git clone https://github.com/Lokaltog/powerline
fi
(cd powerline; python setup.py install --user)
cp powerline/font/PowerlineSymbols.otf $HOME/.fonts
cp powerline/font/10-powerline-symbols.conf $HOME/.fonts.conf.d
mkdir -p $HOME/.config/powerline
cp -r powerline/powerline/config_files/* $HOME/.config/powerline/
