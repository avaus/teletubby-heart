#!/bin/sh

sector_size=512
start_sector=122880
mount_dir="raspbian_img"
mount_path="./$mount_dir"
mount_home="$mount_path/home/pi"

mkdir $mount_path;
if [ $? != 0 ]
  then
    exit 1
fi

mount -o loop,offset=$((sector_size * start_sector)) $2 $mount_path
if [ $? != 0 ]
  then
    rm -r $mount_path
    exit 1
fi

cp auto.desktop $mount_path/etc/xdg/autostart/tubby.desktop
cp local_page.html $mount_home/local_page.html
cp jquery.min.js $mount_home/jquery.min.js
sed -i "s@REPLACE_WITH_URL@$1@g" $mount_home/local_page.html

umount $mount_path
rm -r $mount_path
