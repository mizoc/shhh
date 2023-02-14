#!/usr/bin/env bash

INTERVAL=130 #seconds

while :;do
  if [[ "`playerctl metadata title`" == *Advertisement* || "`playerctl metadata title`" = "" ]];then # Some ads don't have title.
    playerctl volume 0
  else
    playerctl volume 1
  fi
  while ! [[ `playerctl status` == Playing && "`playerctl metadata xesam:url`" == *spotify* ]] ;do
    sleep $INTERVAL
  done
  TIME=$(echo `playerctl metadata mpris:length|sed -e 's/[^0-9]//g'`/1000000 - `playerctl position` + 1.6 | bc) # Adding 1.6 make next loop surely get next song's information.
  if [ `echo "$TIME > $INTERVAL"|bc` -eq 1 ];then
    sleep $INTERVAL
  else
    sleep $TIME
  fi
done
