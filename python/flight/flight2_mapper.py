#!/usr/bin/env python

import sys

header = True;
for line in sys.stdin:
	if header:
		header = False
		continue
	line=line.split(",")
	if line[21] == "1":
		continue
	if line[0] != "":
		print('%s\t%d' % (line[16], 1))