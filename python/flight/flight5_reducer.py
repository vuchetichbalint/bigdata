#!/usr/bin/env python

import sys

lastkey = None
current = 0

for line in sys.stdin:
	line = line.strip()
	key, value = line.split('\t')
	if key != lastkey:
		lastkey = key
		current += 1

print ('%s,%d' % ('osszes',current))