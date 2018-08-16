#!/bin/bash

basurl="ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/"
end="_300arcsec.zip"
# info="bio"
# info="cmi"
# info="pcp"
# info="mint"
# info="maxt"
info="sg"


for y in `seq 1950 2013`
do
  # echo $basurl$info$y$end
  wget $basurl$info$y$end -O "/tmp/"$info$y$end
  unzip "/tmp/"$info$y$end
  mv $y "data/"$info$y
done
