#!/bin/sh

cat part-r-* | awk 'max=="" || $2 > max {max=$2; subject=$1} END{ print max,subject}' FS=" "