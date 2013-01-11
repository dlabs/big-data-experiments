#!/usr/bin/env bash

echo "Recoding years..."

for i in {2000..2011}
do
  if [ ! -f kd$i.zip ];
  then
    echo "Extracting year $i."

    iconv \
      -f "WINDOWS-1250" \
      -t "UTF-8" \
      "./years/$i/KDINTKD.txt" > "./years/$i/KDINTKD.utf8.txt"
  fi
done