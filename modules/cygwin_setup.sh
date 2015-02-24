#!/bin/sh

CYGWIN_URL="https://cygwin.com/setup-x86_64.exe"
CYGWIN_SETUP="setup-x86_64.exe"
CYGWIN_SITE="http://mirrors.163.com/cygwin/"
CYGWIN_ROOT="C:\\cygwin64"
OPT="-q -O -s $CYGWIN_SITE"

# download cygwin setup
wget -N $CYGWIN_URL

# packages
# utils
PKGS="unzip,tree,tmux,p7zip,ascii"

# devel
PKGS="$PKGS,git,gcc,make,ctags,sqlite3,gdb"
PKGS="$PKGS,python,python-openssl,python-setuptools,python-six,python-pygments,python-numpy,python-beautifulsoup"
PKGS="$PKGS,python3,python3-openssl,python3-setuptools,python3-six,python3-pygments,python3-numpy,python3-beautifulsoup"


# network
PKGS="$PKGS,curl,wget,ping,netcat,whois,rsync,lftp"
PKGS="$PKGS,openldap,openldap-devel"
PKGS="$PKGS,penssh,openssl,openssl-devel"
PKGS="$PKGS,mkisofs"

$CYGWIN_SETUP $OPT -P $PKGS

if [ ! -f get-pip.py ]; then
    wget -N https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    python get-pip.py
fi
