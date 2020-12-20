#!/bin/bash

inbox=~/Documents/gtd/inbox.org

note=$(rofi -dmenu -p "TODO")

[[ -z $note ]] && exit

echo "** TODO ${note}" >> $inbox

