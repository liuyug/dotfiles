#!/bin/sh


if [ -d "$(pwd)/myfont" ]; then
    (cd myfont; git pull)
else
    git clone git@github.com:liuyug/myfont.git
fi

(cd myfont; rsync --exclude ".git" -av . $HOME)
fc-cache -vf
