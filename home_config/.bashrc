# append to current home .bashrc
# cat .bashrc >> $HOME/.bashrc

# include bashrc
# if [ -f /etc/bashrc ];then
#     . /etc/bashrc
# fi

export PATH=/sbin:/usr/sbin:$PATH:$HOME/.local/bin:

# in debian, need to run "dpkg-reconfigure locales" and add "zh_CN.UTF-8"
export LANG=zh_CN.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

# My customised VIM
# --enable-pythoninterp --with-features=huge --prefix=$HOME/.local
if [ -f ~/.local/bin/vim ];then
    alias vim=~/.local/bin/vim
fi


export TERM=xterm-256color
export EDITOR=vim

# alias
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
alias ll='ls -l'

platform=`uname -o`
if [ $platform = 'Cygwin' ]; then
    echo "Find platform: $platform"
    chcp.com 65001
fi
