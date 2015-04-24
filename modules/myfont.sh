#!/bin/sh


if [ -d "$(pwd)/myfont" ]; then
    (cd myfont; git pull)
else
    git clone https://github.com/liuyug/myfont.git
fi

# monospace font
(cd myfonts/.fonts; wget http://www.levien.com/type/myfonts/Inconsolata.otf)

# google noto cjk font
# https://www.google.com/get/noto/cjk.html
# S Chinese
# http://www.google.com/get/noto/pkgs/NotoSansCJKSC-hinted.zip
# all-in-one CJK OTC font
(cd myfont/.fonts; wget http://www.google.com/get/noto/pkgs/NotoSansCJK.ttc.zip; unzip -d $HOME/.fonts NotoSansCJK.ttc.zip)

(cd myfont; rsync --exclude ".git" --exclude"*.zip" -av . $HOME)
fc-cache -vf
