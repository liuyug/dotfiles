#!/bin/bash


function init_vim()
{
    sudo apt install vim vim-gui-common ctags python3-pip cmake
    pip3 install jedi pyflakes flake8 --user

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +PlugInstall
}

function get_font()
{
    declare -A fonts=(
        # [powerline]=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
        # [inconsolata]=http://www.levien.com/type/myfonts/Inconsolata.otf
        # [inconsolata_ttf_bold]=https://github.com/googlefonts/Inconsolata/raw/master/fonts/ttf/Inconsolata-Bold.ttf
        # [inconsolata_ttf_regular]=https://github.com/googlefonts/Inconsolata/raw/master/fonts/ttf/Inconsolata-Regular.ttf
        # [consolas]=https://github.com/runsisi/consolas-font-for-powerline/archive/master.zip
        # [yahei_mono]=https://github.com/Microsoft/BashOnWindows/files/1362006/Microsoft.YaHei.Mono.zip
        # [cascadia_code]=https://github.com/microsoft/cascadia-code/releases/download/v2009.22/CascadiaCode-2009.22.zip
        [dejavusans_nerdfont]=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.zip
        [firacode_nerdfont]=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
        [caskaydiacove_nerdfont]=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
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

function init_font()
{
    if [  "$(uname)" = "Darwin" ] ; then
        font_dir="$HOME/Library/Fonts"
    else
        font_dir=$HOME/.local/share/fonts
        mkdir -p $font_dir
    fi

    read -p "Download font to \"$font_dir\". Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # get_font consolas $font_dir
        # get_font powerline $font_dir
        # get_font yahei_mono $font_dir
        # get_font cascadia_code $font_dir
        get_font dejavusans_nerdfont $font_dir
        get_font firacode_nerdfont $font_dir
        get_font caskaydiacove_nerdfont $font_dir
    fi
}

function init_wsl()
{
    if grep -q Microsoft /proc/version; then
        win_user2=`cmd.exe /c "echo %USERNAME%"`
        win_user=`echo $win_user2 | sed 's/\\r//g'`
        win_home="/mnt/c/Users/$win_user"
        echo "Bash for Microsoft Windows"
        echo "=========================="
        echo "Windows user: $win_user"
        echo "Windows user home path: $win_home"
        echo "1. Create links for Windows..."
        ln -s "$win_home/Desktop/" ~/
        ln -s "$win_home/Downloads/" ~/
        ln -s "$win_home/Documents/" ~/
        ln -s "$win_home/Music/" ~/
        ln -s "$win_home/Pictures/" ~/
        echo "2. add Windows fonts..."
        mkdir -p $HOME/.config/fontconfig
        user = `whoami`
        cat > $HOME/.config/fontconfig/fonts.conf << EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <dir>/mnt/c/Windows/Fonts</dir>
    <dir>/mnt/c/Users/$user/AppData/Local/Microsoft/Windows/Fonts</dir>
</fontconfig>
EOF
        echo "3. fix PyQt5..."
        sudo strip --remove-section=.note.ABI-tag  /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
        echo "4. fix file permission..."
        cat > ~/wsl.conf << EOF
[automount]
options = "metadata,umask=22,fmask=11"
EOF
        if [ -f /etc/wsl.conf ]; then
            echo "current /etc/wsl.conf:"
            cat /etc/wsl.conf
        fi
        echo "Manually append below into /etc/wsl.conf:"
        cat ~/wsl.conf
        echo "reboot wsl:"
	echo "net stop LxssManager"
	echo "net start LxssManager"
    fi
}

function init_bash() {
    cat bashrc >> $HOME/.bashrc

    # .ssh/config
    mkdir -p $HOME/.ssh
    cat ssh_config >> $HOME/.ssh/config

    # .local
    mkdir -p $HOME/.local/bin
    cp bin/* $HOME/.local/bin
    chmod u+x $HOME/.local/bin/*

    # .config
    mkdir -p $HOME/.config
    cp -r youtube-dl $HOME/.config
    cp -r nvim $HOME/.config

    cp tmux.conf $HOME/.tmux.conf
}

function init_pytools()
{
    python3 setup.py install --user
}

function init_base()
{
    if [ "$(uname)" = "Linux" ] ; then
        # prepare base app
        sudo apt install rsync wget unzip locales screenfetch x11-apps python3-pyqt5
        # fix locale
        sudo locale-gen zh_CN.UTF-8

    fi
}

if [ "$1" == "--base" -o "$1" == "-b" ]; then
    init_base
elif [ "$1" == "--bash" ]; then
    init_base
    init_bash
elif [ "$1" == "--vim" ]; then
    cp vimrc $HOME/.vimrc
    cp -r vim $HOME/.vim
    init_vim
elif [ "$1" == "--font" ]; then
    init_font
elif [ "$1" == "--wsl" ]; then
    init_wsl
else
    echo "$0 <--bash | --vim | --font | --wsl | --pytools>"
    exit 0
fi
source $HOME/.bashrc
screenfetch

