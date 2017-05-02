#!/bin/sh

STATUS=`DISPLAY=:0 /usr/bin/xrandr | /bin/grep "^DP-1" | /usr/bin/awk '{print $2}'`

if [ "$STATUS" = "connected" ]; then
	DISPLAY=:0 /usr/bin/xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --mode 1920x1200 --pos 1920x0 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
	#~/.config/screenlayout/double.sh
else
	DISPLAY=:0 /usr/bin/xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
	#~/.config/screenlayout/single.sh
fi

i3-msg restart
