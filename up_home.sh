#!/bin/bash


function vim_init()
{
    if [ -d $HOME/.vim/bundle/vundle ]; then
        (cd $HOME/.vim/bundle/vundle; git pull)
    else
        git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
    fi
    vim -c "BundleInstall"
}

function mono_font()
{
    if [ ! -f $HOME/.fonts/Inconsolata.otf ]; then
        mkdir -p $HOME/.fonts
        (cd $HOME/.fonts; wget http://www.levien.com/type/myfonts/Inconsolata.otf)
    fi
}

function doIt() {
    rsync --exclude ".git/"         \
        --exclude ".gitignore"      \
        --exclude ".DS_Store"       \
        --exclude "goagent/"        \
        --exclude "modules/"        \
        --exclude "*.sh"      \
        --exclude "README.rst"      \
        -av                         \
        . $HOME
    mono_font
    fc-cache -f
    vim_init
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
source $HOME/.profile

