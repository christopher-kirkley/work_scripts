#!/usr/bin/env bash

export LABEL="/media/share/sahel_label"

find ~/Downloads -regex ".*SSinv.*\.pdf" -exec mv {} $LABEL/admin/secretly/inventory \;

find ~/Downloads -regex ".*SSwhfees.*\.xlsx" -exec mv {} $LABEL/admin/secretly/fees \;

