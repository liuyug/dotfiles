#!/bin/bash

if [ "x$1" = "x" ];then
    #rand_str=$(tr -dc "[:digit:]" < /dev/urandom | head -c 4)
    rand_str=$(date +"%H%M%S")
    sname=3P_$rand_str
else
    sname=$1
fi


# split 3 panel 
tmux new-session -d -s $sname
tmux split-window -h
tmux select-pane -t:0.1
tmux split-window -v
tmux attach -t $sname



