#!/bin/sh

git clone https://github.com/Lokaltog/powerline
(cd powerline; sudo python setup.py install)
cp powerline/font/PowerlineSymbols.otf $HOME/.fonts
cp powerline/font/10-powerline-symbols.conf $HOME/.fonts.conf.d

