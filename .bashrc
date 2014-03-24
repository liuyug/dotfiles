# NOTE
# When bash invoked with --login options, it will read file, /etc/profile,
# ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order and read
# ~/.bash_logout when logout.
# If bash is not login shell, it will read ~/.bashrc


if [ -f /etc/bashrc ];then
    . /etc/bashrc
fi

export PATH=/sbin:/usr/sbin:$PATH:$HOME/bin:$HOME/.local/bin:

export LANG=zh_CN.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

if [ -f /usr/bin/vimx ];then
    alias vim=vimx
fi


export TERM=xterm-256color
export EDITOR=vim


