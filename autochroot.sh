#!/usr/bin/env sh

if [ "$EUID" -ne 0 ]
  then echo "The current user must be root!"
  exit
fi

dir=$(echo $1 | sed -e 's/^\(.*\)\/$/\1/')

mount --rbind /dev $dir/dev
mount --make-rslave $dir/dev
mount -t proc /proc $dir/proc
mount --rbind /sys $dir/sys
mount --make-rslave $dir/sys
mount --rbind /tmp $dir/tmp 

chroot $dir /bin/sh --login +h
