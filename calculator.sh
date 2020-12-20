#!/bin/bash

# calculator script, uses rofi calculator plugin
# https://github.com/svenstaro/rofi-calc
# needs a script because clipboard doesn't work in i3 keybindings

rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n '{result}' | xclip"
