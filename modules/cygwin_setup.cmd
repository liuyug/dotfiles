@echo off
rem cygwin download url: https://cygwin.com/setup-x86_64.exe
set CYGWIN_SETUP=setup-x86_64.exe
set CYGWIN_SITE=http://mirrors.163.com/cygwin/
set CYGWIN_ROOT=C:\cygwin64
set OPT=-q -O -s %CYGWIN_SITE%

rem packages
rem utils
set PKGS=unzip,tree,tmux,p7zip,ascii

rem devel
set PKGS=%PKGS%,git,gcc,make,ctags,sqlite3,gdb
set PKGS=%PKGS%,python,python-openssl,python-setuptools,python-sip

rem network
set PKGS=%PKGS%,curl,wget,ping,netcat,whois,rsync,lftp
set PKGS=%PKGS%,openldap,openldap-devel
set PKGS=%PKGS%,penssh,openssl,openssl-devel

echo on

%CYGWIN_SETUP% %OPT% -P %PKGS%
