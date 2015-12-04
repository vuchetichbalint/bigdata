#!/usr/bin/env python

import sys

header = True;
for line in sys.stdin:
	if header:
		header = False
		continue
	line=line.split(",")
	if line[0] != "":
		print('%s\t%d' % (line[16]+','+line[17], 1))