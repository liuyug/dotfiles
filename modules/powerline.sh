#!/bin/sh


if [ -d "$(pwd)/powerline" ]; then
    (cd powerline; git pull)
else
    git clone https://github.com/Lokaltog/powerline
fi
(cd powerline; sudo python setup.py install)
cp powerline/font/PowerlineSymbols.otf $HOME/.fonts
cp powerline/font/10-powerline-symbols.conf $HOME/.fonts.conf.d
mkdir -p $HOME/.config
cp -r powerline/powerline/config_files/* $HOME/.config/powerline/
mkdir -p $HOME/.vim
cp -r powerline/powerline/bindings/vim/plugin/ $HOME/.vim/
