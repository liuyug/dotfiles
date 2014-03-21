#!/bin/sh

curl -L https://github.com/shimmerproject/Greybird/tarball/master -o Greybird.tar.gz
curl -L https://github.com/shimmerproject/elementary-xfce/tarball/master -o elementary-xfce.tar.gz

mkdir -p ${HOME}/.themes
mkdir -p ${HOME}/.icons

tar xvf Greybird.tar.gz -C ${HOME}/.themes
tar xvf elementary-xfce.tar.gz -C ${HOME}/.icons --strip-components 1
