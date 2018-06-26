#!/bin/bash


function vim_init()
{
    sudo apt install vim vim-gui-common ctags python3-pip
    pip3 install jedi pyflakes flake8 --user
    if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
        (cd $HOME/.vim/bundle/Vundle.vim; git pull)
    else
        git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +qall
}

function get_font()
{
    declare -A fonts=(
        [powerline]=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
        [inconsolata]=http://www.levien.com/type/myfonts/Inconsolata.otf
        [consolas]=https://github.com/runsisi/consolas-font-for-powerline/archive/master.zip
        [yahei.mono]=https://github.com/Microsoft/BashOnWindows/files/1362006/Microsoft.YaHei.Mono.zip
    )

    url=${fonts[$1]}
    file=`basename $url`

    echo "Get font $file from $url"

    font_dir=$HOME/.local/share/fonts

    if [ ! -f $font_dir/$file ]; then
        mkdir -p $font_dir
        (
        cd $font_dir
        wget $url
        case "$file" in
            *.zip)
                unzip -o -j $file
                rm -f $file
                ;;
            *)
                ;;
        esac
        )
    fi
}

function doIt() {
    sudo apt install rsync wget unzip

    rsync \
        --exclude ".bashrc"         \
        --exclude ".xsessionrc"     \
        -av                         \
        home_config/ $HOME
    cat home_config/.bashrc >> $HOME/.bashrc
    vim_init
}

if grep -q Microsoft /proc/version; then
    echo "Find Linux for Microsoft..."
    if [ "$(umask)" == '0000' ]; then
        umask 0022
    fi
fi

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
    read -p "Download font to \"\$HOME/.local/share/fonts\". Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        get_font consolas
        get_font inconsolata
        get_font powerline
        get_font yahei.mono
    fi

    if grep -q Microsoft /proc/version; then
        echo "Bash for Microsoft Windows"
        echo "=========================="
        echo "1. Install Windows Font..."
        (cd $HOME/.local/share/fonts
        fontview.exe Microsoft YaHei Mono.ttf
        fontview.exe PowerlineSymbols.otf
        )
        echo "2. Fix Windows FontLink..."
        echo '   Run as administrator: reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Microsoft YaHei Mono" /t REG_MULTI_SZ /d "Powerline Consolas.ttf,Powerline Consolas"'
        echo ""
    fi
fi
source $HOME/.bashrc

