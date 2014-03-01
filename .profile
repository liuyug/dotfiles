
export PATH=/sbin:/usr/sbin:$PATH:$HOME/bin:$HOME/.local/bin:

export LANG=zh_CN.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

if [ -f /usr/bin/vimx ];then
    alias vim=vimx
fi
if [ -f $HOME/.bashrc ];then
    source $HOME/.bashrc
fi


export TERM=xterm-256color
export EDITOR=vim


