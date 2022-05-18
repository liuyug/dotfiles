# append to current home .bashrc
# cat .bashrc >> $HOME/.bashrc

export PATH=/sbin:/usr/sbin:$PATH:$HOME/.local/bin

# in debian, need to run "dpkg-reconfigure locales" and add "zh_CN.UTF-8"
export LANG=zh_CN.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_TIME=en_US.UTF-8

export TERM=xterm-256color
export EDITOR=vim

export DISPLAY=:0.0

# use Software OpenGL render with VcXsrv -nowgl
# export LIBGL_ALWAYS_INDIRECT=0

# alias
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'

if grep -q Microsoft /proc/version; then
    if [ "$(umask)" == '0000' ]; then
        umask 0022
    fi
fi

# use PulseAudio
# sudo apt install libpulse0
# pax11publish
# export PULSE_SERVER="tcp:127.0.0.1"
# export PULSE_SERVER="tcp:192.168.100.157"
# in PulseAudio Server
# default.pa
# load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.100.0/24
# daemon.conf
# exit-idle-time = -1


