# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

export LANG=zh_CN.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

export TERM=xterm-256color
#. /usr/lib/python2.6/site-packages/Powerline-beta-py2.6.egg/powerline/bindings/bash/powerline.sh

if [ -f /usr/bin/vimx ];then
    alias vim=vimx
fi


