#!/usr/bin/env bash

echo "Downloading archives..."

for i in {2000..2011}
do
  if [ ! -f kd$i.zip ];
  then
    echo "Downloading year $i."
    curl -o "zips/$i.zip" "http://www.policija.si/baza/kd$i.zip" &> /dev/null
  fi
done