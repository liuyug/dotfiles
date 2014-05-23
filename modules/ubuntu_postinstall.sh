#!/bin/sh

echo "Need root privilege to run"


cat <<EOF >> /etc/apt/sources.list
deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
EOF
apt-get update

normal="vim git curl lynx wget ssh tmux python-pip"
dev="build-essential cmake"


for item in `echo $normal`; do
    echo "Install $item"
    apt-get install $item
done



# vim: ts=4 sw=4 et tw=79

