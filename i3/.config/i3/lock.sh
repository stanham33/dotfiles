#!/bin/bash

IMAGE="$HOME/.config/i3/lock-hacker.png"
#IMAGE="/tmp/screen_locked.png"

#scrot $IMAGE

#if [[ $# -eq 1 ]] && [[ "$1" == "blur"  ]]; then
#	convert $IMAGE -blur "0x5" $IMAGE
#fi
i3lock -f -e -p win -i $IMAGE -t
