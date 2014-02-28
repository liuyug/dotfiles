#!/bin/sh

if [ "x$1" = "x" ];then
    #rand_str=$(tr -dc "[:digit:]" < /dev/urandom | head -c 4)
    rand_str=$(date +"%H%M%S")
    sname=4P_$rand_str
else
    sname=$1
fi


# split 4 panel 
tmux new-session -d -s $sname
tmux split-window -h
tmux select-pane -t:0.0
tmux split-window -v
tmux select-pane -t:0.2
tmux split-window -v
tmux attach -t $sname



