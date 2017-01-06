# append to current home .bashrc
# cat .bashrc >> $HOME/.bashrc

platform=`uname -o`

if [ $platform = 'Cygwin' ]; then
    echo "Find platform: $platform"
    chcp.com 65001
elif [ $platform = 'GNU/Linux' ]; then
    WIN32_PATH=/mnt/c/Windows:/mnt/c/Windows/System32
    PATH=$PATH:$WIN32_PATH
fi

export PATH=/sbin:/usr/sbin:$PATH:$HOME/.local/bin

# in debian, need to run "dpkg-reconfigure locales" and add "zh_CN.UTF-8"
export LANG=zh_CN.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

export TERM=xterm-256color
export EDITOR=vim

# alias
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
