#!/bin/bash

# force use ALSA, default PLUSE
# AE_SINK=ALSA

su - kodi -c "xinit kodi-standalone -- :0"

# vim: tabstop=4 shiftwidth=4 expandtab
