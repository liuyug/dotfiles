#!/bin/sh


if [ -d "$(pwd)/powerline" ]; then
    (cd powerline; git pull)
else
    git clone https://github.com/Lokaltog/powerline
fi
(cd powerline; python setup.py install --user)

# powerline font
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
cp PowerlineSymbols.otf $HOME/.fonts
cp 10-powerline-symbols.conf $HOME/.fonts.conf.d

# powerline config files
mkdir -p $HOME/.config/powerline
cp -r powerline/powerline/config_files/* $HOME/.config/powerline/
