#!/usr/bin/env bash

# By Oto Brglez - <oto.brglez@opalab.com>

echo "Gatherin data from policija.si (2000-2011)"

# Download zips if they dont exist yet
for i in {2000..2011}
do
  if [ ! -f kd$i.zip ];
  then
    echo "Downloading year $i."
    curl -O "http://www.policija.si/baza/kd$i.zip" &> /dev/null
  fi
done

# Remove
if [ -f KDINTKDO-complete.txt ];
then
  echo "Removing old merge."
  rm KDINTKDO-complete.txt
  rm KDINTKD-complete.txt
fi

# Extract zips and merge to previous
for i in {2000..2011}
do
  echo "Merging year $i"
  unzip -qq -o -C -j -L kd$i.zip \
    KDINTKD.txt KDINTKDO.txt \
    prenosi/POLJFTP/KDINTKD.txt \
    prenosi/POLJFTP/KDINTKDO.txt &> /dev/null

  # iconv must go here.
  # file -I KDINTKD.txt
  # iconv -t UTF-8 KDINTKD.txt > KDINTKD.txt-utf8

  if [ -f kdintkd.txt ];
  then
    cat kdintkd.txt >> KDINTKD-complete.txt
    # rm KDINTKD.txt*
  fi

  if [ -f kdintkdo.txt ];
  then
    cat kdintkdo.txt >> KDINTKDO-complete.txt
    # rm KDINTKDO.txt*
  fi
done

rm -rf *.zip
rm -rf kdintkd.txt
rm -rf kdintkdo.txt

