#!/bin/bash

POWERLINE_PATH=$(python -c " 
import os
print ''.join([item for item in os.sys.path if 'Powerline' in item])
")

POWERLINE_VIM="$POWERLINE_PATH/powerline/bindings/vim/plugin/powerline.vim"


function doIt() {
    rsync --exclude ".git/"         \
        --exclude ".gitignore"      \
        --exclude ".DS_Store"       \
        --exclude "goagent/"        \
        --exclude "bootstrap.sh"    \
        --exclude "up_home.sh"      \
        --exclude "README.rst"      \
        -av                         \
        . $HOME
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
unset doIt
source ~/.profile

