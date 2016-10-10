#!/bin/bash

if [ "x$1" = "x" ];then
    #rand_str=$(tr -dc "[:digit:]" < /dev/urandom | head -c 4)
    rand_str=$(date +"%H%M%S")
    sname=2P_$rand_str
else
    sname=$1
fi

cur_dir=`pwd`
# split 2 panel
tmux new-session -d -s $sname -c "$cur_dir"
tmux split-window -h -c "$cur_dir"
tmux attach -t $sname



