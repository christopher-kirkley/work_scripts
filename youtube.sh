#!/bin/bash

vid=$(rofi -dmenu -p "youtube")

[[ -z $vid ]] && exit	

youtube-dl -o '~/Downloads/youtube/%(title)s' $vid

