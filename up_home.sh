#!/bin/bash

POWERLINE_PATH=$(python -c " 
import os
print ''.join([item for item in os.sys.path if 'Powerline' in item])
")

POWERLINE_VIM="$POWERLINE_PATH/powerline/bindings/vim/plugin/powerline.vim"

function mono_font() 
{
    if [ ! -f $HOME/.fonts/Inconsolata.otf ]; then
        (cd $HOME/.fonts; wget http://www.levien.com/type/myfonts/Inconsolata.otf)
    fi
}

function doIt() {
    rsync --exclude ".git/"         \
        --exclude ".gitignore"      \
        --exclude ".DS_Store"       \
        --exclude "goagent/"        \
        --exclude "modules/"        \
        --exclude "up_home.sh"      \
        --exclude "README.rst"      \
        -av                         \
        . $HOME
    mono_font
    fc-cache -f
    if [ -f $POWERLINE_VIM ]; then
        rsync -av $POWERLINE_VIM $HOME/.vim/plugin/powerline.vim
    fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
source ~/.profile

