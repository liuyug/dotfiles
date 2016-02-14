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

function get_font()
{
    fonts=(
        [powerline]=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
        [inconsolata]=http://www.levien.com/type/myfonts/Inconsolata.otf
    )

    url=${fonts[$1]}
    file=`basename $url`

    echo "Get font $file from $url"

    if [ ! -f $HOME/.fonts/$file ]; then
        mkdir -p $HOME/.fonts
        (cd $HOME/.fonts; wget $url)
    fi
}

function powerline_font()
{
    url = https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    file = `basename $url`
    if [ ! -f $HOME/.fonts/$file ]; then
        mkdir -p $HOME/.fonts
        (cd $HOME/.fonts; wget $url)
    fi
}

function doIt() {
    rsync \
        --exclude ".fonts.conf"     \
        --exclude ".bashrc"         \
        --exclude ".xsessionrc"     \
        -av                         \
        home_config/ $HOME
    cat home_config/.bashrc >> $HOME/.bashrc
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
    read -p "Download Inconsolata and POWERLINE font to \"\$HOME/.fonts\". Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        get_font inconsolata
        get_font powerline
    fi

fi
source $HOME/.bashrc

