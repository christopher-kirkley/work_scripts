#!/bin/env bash

maim -s | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap \
        -background none -layers merge +repage ~/Pictures/screenshots/$(date +%Y-%d-%m-%T).png

