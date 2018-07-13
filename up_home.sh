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
    rsync \
        --exclude ".bashrc"         \
        -av                         \
        home_config/ $HOME
    cat home_config/.bashrc >> $HOME/.bashrc
    vim_init
}

# prepare base app
sudo apt install rsync wget unzip screenfetch
# fix locale
sudo locale-gen zh_CN.UTF-8

# fix Windows Bash
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
        win_user2=`cmd.exe /c "echo %USERNAME%"`
        win_user=`echo $win_user2 | sed 's/\\r//g'`
        win_home="/mnt/c/Users/$win_user"
        echo "Bash for Microsoft Windows"
        echo "=========================="
        echo "Windows user: $win_user"
        echo "Windows user home path: $win_home"
        echo "1. Create links for Windows..."
        ln -s "$win_home/Desktop/"
        ln -s "$win_home/Downloads/"
        ln -s "$win_home/Documents/"
        echo "2. Copy fonts to Documents folder..."
        cp -rf $HOME/.local/share/fonts ~/Documents/
        echo "3. Fix Windows Bash Font..."
        echo "   Install fonts in Documents"
        echo '   Run as administrator: reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Microsoft YaHei Mono" /t REG_MULTI_SZ /d "Powerline Consolas.ttf,Powerline Consolas"'
        echo ""
    fi
fi
source $HOME/.bashrc
screenfetch

