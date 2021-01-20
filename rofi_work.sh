#!/bin/env bash

option=$(echo -e "isrc\nrelease_dates\ntest" | rofi -show run -dmenu -p "script: ")

[[ -z $option ]] && exit	

case $option in
	isrc) urxvt -e "/home/ck/work_scripts/isrc-generator/isrc.py";;
	release_dates) urxvt -e "/home/ck/work_scripts/release_dates_script/run.sh";;
	test) urxvt -e "/home/ck/scripts/test.py";;
esac

