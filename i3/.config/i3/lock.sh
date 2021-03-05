#!/bin/bash

IMAGE_HACK="$HOME/.config/i3/lock-hacker.png"
IMAGE_TRIPLE="$HOME/Pictures/wallpapers/forest.png"

monitors=`xrandr |grep connected | grep 2560x1440 | wc -l`
if [ $monitors -eq 3 ];then
    IMAGE=$IMAGE_TRIPLE
else
    IMAGE=$IMAGE_HACK
fi

# Mute Audio
pactl set-sink-mute 1 1

# Lock Bitwarden
bw lock

i3lock -f -e -p win -i $IMAGE -t
