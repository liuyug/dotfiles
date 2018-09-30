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
        [yahei_mono]=https://github.com/Microsoft/BashOnWindows/files/1362006/Microsoft.YaHei.Mono.zip
    )

    url=${fonts[$1]}
    file=`basename $url`
    echo "Get font $file from $url"

    font_dir="$2"
    if [ "x$2" = "x" ]; then
        if [  "$(uname)" = "Darwin" ] ; then
            font_dir="$HOME/Library/Fonts"
        else
            font_dir=$HOME/.local/share/fonts
            mkdir -p $font_dir
        fi
    fi

    if [ ! -f $font_dir/$file ]; then
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
    fc-cache -f "$font_dir"
}

function doIt() {
    rsync \
        --exclude ".bashrc"         \
        -av                         \
        home_config/ $HOME
    cat home_config/.bashrc >> $HOME/.bashrc
    vim_init
}

if [ "$(uname)" = "Linux" ] ; then
    # prepare base app
    sudo apt install rsync wget unzip locale screenfetch
    # fix locale
    sudo locale-gen zh_CN.UTF-8

    # fix Windows Bash
    if grep -q Microsoft /proc/version; then
        echo "Find Linux for Microsoft..."
        if [ "$(umask)" == '0000' ]; then
            umask 0022
        fi
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

    if [  "$(uname)" = "Darwin" ] ; then
        font_dir="$HOME/Library/Fonts"
    else
        font_dir=$HOME/.local/share/fonts
        mkdir -p $font_dir
    fi

    read -p "Download font to \"$font_dir\". Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        get_font consolas $font_dir
        get_font inconsolata $font_dir
        get_font powerline $font_dir
        get_font yahei_mono $font_dir
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
        ln -s "$win_home/Music/"
        ln -s "$win_home/Pictures/"
        echo "2. Copy fonts to Documents folder..."
        cp -rf $HOME/.local/share/fonts ~/Documents/
        echo "3. Fix Windows Bash Font..."
        echo "   Install fonts in Documents"
        echo '   Run below as administrator:'
        echo '   reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Microsoft YaHei Mono" /t REG_MULTI_SZ /d "Powerline Consolas.ttf,Powerline Consolas"'
        # 拉丁字母及常见ASCII符号（0-9，a-z，A-Z，!@#$%^等）显示字体为【Consolas】
        # 中文、日语等CJK字符&符号显示字体为【微软雅黑】
        # Powerline Symbols【Powerline Consolas】
        # 特殊符号显示字体为【Segoe UI Symbol】
        echo '   reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Consolas" /t REG_MULTI_SZ /d "MSYH.TTC,Microsoft YaHei,128,96\0MSYH.TTC,Microsoft YaHei\0Powerline Consolas.ttf,Powerline Consolas"'
        echo '   reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Inconsolata" /t REG_MULTI_SZ /d "MSYH.TTC,Microsoft YaHei,128,96\0MSYH.TTC,Microsoft YaHei\0Powerline Consolas.ttf,Powerline Consolas"'
        echo ""
    fi
fi
source $HOME/.bashrc
screenfetch

