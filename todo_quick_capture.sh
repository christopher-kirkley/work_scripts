#!/bin/bash

inbox=~/Documents/gtd/inbox.org

note=$(rofi -dmenu -p "note")

[[ -z $note ]] && exit

echo "** TODO ${note}" >> $inbox

