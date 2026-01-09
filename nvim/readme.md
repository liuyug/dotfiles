# Nvim

## Config

~/AppData/Local/nvim/init.vim
~/AppData/Local/nvim/lua/init.lua


## Git
It access remote server through SSH
disable external SSH and use internal windows ssh
```
set GIT_SSH=
set SVN_SSH=
ssh config: ~/.ssh
```

## telescope
usage:
<tab> -- select some items, <shift + tab> to toggle item
<alt + q> -- send filtered result to quickfix
<ctrl + q> -- send unfiltered result to quickfix
:cfdo %s/{find}/{replace}/g | update -- replace and save
:cclose -- close quickfix

