#!/bin/bash

ls -t ~/Downloads/moonlander*.bin | head -1 | xargs -I {} wally {}
