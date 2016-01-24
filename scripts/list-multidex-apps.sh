#!/system/bin/sh
###########################################################
# Copyright (C) 2016 Jared Rummler
# Licensed under GPLv3
# 
# DESCRIPTION
#   List apps which are using multidex
# 

for line in $(pm list packages -f)
do
  apk=$(echo $line | cut -d: -f2 | cut -d= -f1)
  ret=$(unzip -l "${apk}" | grep classes2.dex)
  if [ -n "${ret}" ]
  then
    package_name=$(echo $line | cut -d: -f2 | cut -d= -f2)
    echo "$package_name"
  fi
done
