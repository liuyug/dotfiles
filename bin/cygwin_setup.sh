#!/bin/sh

# cygwin setup program
CYGWIN_URL="https://cygwin.com/setup-x86_64.exe"
CYGWIN_SETUP="D:\\Downloads\\cygwin-setup.exe"

# cygwin packages
# mirror site
CYGWIN_SITE="http://mirrors.163.com/cygwin/"
# local package dir
CYGWIN_LOCAL_PKGS_DIR="D:\\Downloads"

# cygwin install root
CYGWIN_ROOT="C:\\cygwin64"

# cygwin setup runtime parameter
OPT="-q -R $CYGWIN_ROOT -l $CYGWIN_LOCAL_PKGS_DIR -O -s $CYGWIN_SITE"

usage()
{
    echo "$0 <cmd>"
    echo "command:"
    echo "init                              first setup"
    echo "download                          download latest cygwin setup"
    echo "install [package name] [...]      install package"
    echo "remove [package name] [...]       remove package"
    exit 0
}

download_setup()
{
    # download cygwin setup
    wget -N $CYGWIN_URL -O $CYGWIN_SETUP
}

init_setup()
{
    # packages
    # utils
    PKGS="unzip,tree,tmux,p7zip,ascii"

    # devel
    PKGS="$PKGS,git,gcc,make,ctags,sqlite3,gdb"
    PKGS="$PKGS,freetype,png"
    PKGS="$PKGS,python,python-openssl,python-setuptools,python-six,python-pygments,python-numpy,python-beautifulsoup"
    PKGS="$PKGS,python3,python3-openssl,python3-setuptools,python3-six,python3-pygments,python3-numpy,python3-beautifulsoup"


    # network
    PKGS="$PKGS,curl,wget,ping,netcat,whois,rsync,lftp"
    PKGS="$PKGS,openldap,openldap-devel"
    PKGS="$PKGS,penssh,openssl,openssl-devel"
    PKGS="$PKGS,mkisofs"
    install_pkgs $PKGS
}

install_pkgs()
{
    PKGS=$1
    cmd /c "$CYGWIN_SETUP $OPT -P $PKGS"
}

remove_pkgs()
{
    PKGS=$1
    cmd /c "$CYGWIN_SETUP $OPT -x $PKGS"
}

install_python_pip()
{
    if [ ! -f get-pip.py ]; then
        wget -N https://bootstrap.pypa.io/get-pip.py
        python3 get-pip.py
        python get-pip.py
    fi
}

if [ "x"$1 = "xinit" ]; then
    init_setup
elif [ "x"$1 = "xdownload" ]; then
    download_setup
elif [ "x"$1 = "xinstall" ]; then
    install_pkgs $2
elif [ "x"$1 = "xremove" ]; then
    remove_pkgs $2
else
    usage
fi
