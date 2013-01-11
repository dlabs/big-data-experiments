#!/usr/bin/env bash

echo "Extracting zips..."

for i in {2000..2011}
do
  if [ ! -f kd$i.zip ];
  then
    echo "Extracting year $i."

    rm -rf "years/*"

    unzip ./zips/$i.zip -d ./years/$i
  fi
done