#!/bin/sh

cat flight2/* > flight2_sum.csv

awk 'max=="" || $2 > max {max=$2; subject=$1} END{ print max,subject}' FS="," flight2_sum.csv