#!/bin/bash

desc=$(task +ACTIVE 2>&1 | grep '[0-9][s|min|h]' | awk '{print $4;exit}')
priority="None"
if [ "$desc" == "L" ] || [ "$desc" == "M" ] || [ "$desc" == "H" ];then
  priority=$desc
  desc=$(task +ACTIVE 2>&1 | grep '[0-9][s|min|h]' | awk '{print $5;exit}')
fi

active=$(task +ACTIVE 2>&1 | grep '[0-9][s|min|h]' | awk '{print $2;exit}')

if [ "$desc" == "" ];then
  echo "No active tasks"
else
  echo "$desc --> $active"
  if [ "$active" == "30min" ];then
    notify-send "task $desc" "Task started $active ago !"
  fi
fi
