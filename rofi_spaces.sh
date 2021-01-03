#!/bin/env bash

space=$(echo -e "work\ntodo" | rofi -dmenu -p "space")

[[ -z $space ]] && exit	

case $space in
	work) $HOME/scripts/startapp.sh;;
	todo) echo 'hey';
esac

