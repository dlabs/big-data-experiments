#!/usr/bin/env bash

echo "Formating files..."

for i in {2000..2011}
do
  echo "Formating year $i."

  ruby kd_formater.rb \
    "./years/$i/kd.txt" \
    "./years/$i/kd_f_out.csv"
done