#!/bin/env bash

# Sync GTD files to Dropbox

rsync -ar /home/ck/Documents/gtd/ /home/ck/Dropbox/backup/gtd/ --delete
