#!/bin/bash


function vim_init()
{
    if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
        (cd $HOME/.vim/bundle/Vundle.vim; git pull)
    else
        git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +qall
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
        --exclude "README.rst"      \
        --exclude "up_home.sh"      \
        --exclude ".bashrc"         \
        --exclude ".xsessionrc"     \
        -av                         \
        . $HOME
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
source $HOME/.bashrc

