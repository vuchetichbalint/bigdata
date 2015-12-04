#!/bin/sh

cat flight5/* | awk 'BEGIN { FS = "," } ; { print $2}' | awk '{ sum+=$1} END {print sum}' > flight5_sum.csv