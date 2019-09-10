#!/bin/bash

if [ "x$1" = "x" ];then
    #rand_str=$(tr -dc "[:digit:]" < /dev/urandom | head -c 4)
    rand_str=$(date +"%H%M%S")
    sname=4P_$rand_str
else
    sname=$1
fi


cur_dir=`pwd`
# split 4 panel 
tmux new-session -d -s $sname -c "$cur_dir"
tmux split-window -h -c "$cur_dir"
tmux select-pane -t:0.0
tmux split-window -v -c "$cur_dir"
tmux select-pane -t:0.2
tmux split-window -v -c "$cur_dir"
tmux attach -t $sname



