#!/bin/sh

echo "Need root privilege to run"

softwares="vim git curl wget ssh tmux python-pip"
dev="build-essential cmake"


for item in `echo $softwares`; do
    echo "Install $item"
    apt-get install $item
done

