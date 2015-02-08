#!/bin/sh

if [ -d "$(pwd)/genpac" ]; then
    (cd genpac; git pull)
else
    git clone https://github.com/liuyug/genpac
fi

cd genpac

cat <<EOF >proxy.rules
!
! 语法与gfwlist相同，即AdBlock Plus过滤规则
!
! 简单说明如下：
! 1. 通配符支持，如 *.example.com/* 实际书写时可省略* 如.example.com/ 意即*.example.com/*
! 2. 正则表达式支持，以\开始和结束， 如 \[\w]+:\/\/example.com\
! 3. 例外规则 @@，如 @@*.example.com/* 满足@@后规则的地址不使用代理
! 4. 匹配地址开始和结尾 |，如 |http://example.com、example.com|分别表示以http://example.com开始和以example.com结束的地址
! 5. || 标记，如 ||example.com 则http://example.com、https://example.com、ftp://example.com等地址均满足条件
! 6. 注释 ! 如 ! Comment
!
! 更详细说明 请访问 http://adblockplus.org/en/filters
!

||ggpht.com
||google-analytics.com
||play.google.com
||google.com
||googlemail.com
||storage.evozi.com
||sweethome3d.com
||googleapis.com
||googlecode.com
||android.com
||python-excel.org
EOF

cat <<EOF >config.ini
[config]
proxy = "SOCKS5 127.0.0.1:1080"
gfwlist-proxy = SOCKS5 127.0.0.1:1080
user-rule-from = proxy.rules
output = proxy.pac
EOF


python genpac --config-from config.ini

cd ..

# vim: tabstop=4 shiftwidth=4 expandtab
