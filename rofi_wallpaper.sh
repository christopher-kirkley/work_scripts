#!/bin/env bash

wallpaper=$(ls "$HOME/Pictures/wallpaper" | rofi -dmenu -p "wallpaper")

[[ -z $wallpaper ]] && exit	

$HOME/fehbg.sh $wallpaper

