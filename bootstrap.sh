#!/bin/bash
#cd "$(dirname "${BASH_SOURCE}")"
#git pull
function doIt() {
    rsync --exclude ".git/"         \
        --exclude ".gitignore"      \
        --exclude ".DS_Store"       \
        --exclude "goagent/"        \
        --exclude "bootstrap.sh"    \
        --exclude "README.rst"      \
        -a                          \
        . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt
source ~/.profile

