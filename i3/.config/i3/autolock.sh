#!/bin/sh
xautolock -time 1 -notify 60 -notifier "notify-send -u critical -t 10000 'LOCKING SCREEN IN 60 SECONDS'" -locker "~/.config/i3/lock.sh" &
