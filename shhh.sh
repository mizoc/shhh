#!/usr/bin/env bash

while :;do
  if [[ "`playerctl metadata title`" == *Advertisement* || "`playerctl metadata title`" = "" ]];then # Some ads don't have title.
    playerctl volume 0
  else
    playerctl volume 1
  fi
  while ! [[ `playerctl status` == Playing && "`playerctl metadata xesam:url`" == *spotify* ]] ;do
    sleep 60
  done
  sleep $(echo `playerctl metadata mpris:length|sed -e 's/[^0-9]//g'`/1000000 - `playerctl position`+1.6|bc) # Adding 1.6 make next loop surely get next song's information.
done
