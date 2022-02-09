#!/usr/bin/env sh
size=$(du -m "$1" | awk '{print $1}')
calc "30+(-365+30)*($size/512-1)^3" | xargs echo "Days: " < /dev/stdin
