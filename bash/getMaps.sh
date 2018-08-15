#!/bin/bash

basurl="ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/bio";

for y in `seq 1950 2013`
do
  wget "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/bio"$y"_300arcsec.zip" -O "/tmp/bio"$y"_300arcsec.zip"
  unzip "/tmp/bio"$y"_300arcsec.zip"
  mv $y "data/bio"$y
done
