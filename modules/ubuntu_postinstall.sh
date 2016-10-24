#!/bin/sh

codename=`lsb_release -c|cut -f2`

lsb_release -a

cat <<EOF >> /etc/apt/sources.list
deb http://cn.archive.ubuntu.com/ubuntu/ $codename main restricted universe
deb http://cn.archive.ubuntu.com/ubuntu/ $codename-updates main restricted universe
# deb http://cn.archive.ubuntu.com/ubuntu/ $codename-backports main restricted universe
deb http://security.ubuntu.com/ubuntu/ $codename-security main restricted universe
EOF

apt-get update
apt-get upgrade

normal="sudo vim vim-gui-common git curl lynx wget ssh tmux python-pip rsync"
vmware="open-vmware-tools"
dev="build-essential cmake"


for item in `echo $normal $vmware $dev`; do
    echo "Install $item"
    apt-get install $item
done

# vim: ts=4 sw=4 et tw=79
