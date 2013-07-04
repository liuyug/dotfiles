===========
My DotFiles
===========

Install modules
=====================
1. modules shell
::

    (cd modules; sh modules.sh)

2. Goagent

::

    git clone https://github.com/goagent/goagent.git
    mkdir -p $HOME/.pki/nssdb
    # add appid into goagent/local/proxy.ini
    python goagent/local/proxy.py

XFCE
====

1. XFCE theme

::

   git clone https://github.com/shimmerproject/Greybird $HOME/.themes/

2. Elementary icons

   download from http://danrabbit.deviantart.com/art/elementary-Icons-65437279
   and put in $HOME/.icons/

User Guide
==========
VIM does not support system clipboard in console. You must use the copy/paste feature of TMUX. In my dotfiles, ```<C-a><ESC>``` to enter copy mode, ```v``` to begin selection, ```y``` to copy the selected area to TMUX clipboard, and ```<C-a>p``` to paste in TMUX. To copy to system clipboard, after copy TMUX clipboard, ```<C-a><C-c>``` to copy to system clipboard.

