#!/bin/env bash

option=$(echo -e "reboot\nshutdown" | rofi -dmenu -p "power")

[[ -z $option ]] && exit	

case $option in
	reboot) reboot;;
	shutdown) shutdown -h now;;
esac

