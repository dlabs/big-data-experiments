#!/usr/bin/env bash

echo "Sample 100 lines of each..."

for i in {2000..2011}
do
  if [ ! -f kd$i.zip ];
  then
    echo "Cuting first 100 lines of $i."

    head -n 100 "years/$i/kd.txt" > "years/$i/kd_100.txt"
  fi
done