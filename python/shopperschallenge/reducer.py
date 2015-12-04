#!/usr/bin/python

import sys

lastkey = None
current = 0

for line in sys.stdin:
    line = line.strip()
    key, value = line.split('\t')
    try:
        value = int(value)
        if key != lastkey:
            if lastkey is not None:
                print ('%s\t%d' % (lastkey, current))
            lastkey = key
            current = 0
        current += value
    except ValueError:
        pass

if lastkey is not None:
    print ('%s\t%d' % (lastkey,current))



##--------------------------------------------------------------------------------------
##test


#import sys
##data = {"2012-9,7	1","2012-9,7	1","2012-9,7	1","2012-9,25	2","2012-9,55	3","2012-9,59	3","2012-9,59	4","2012-9,63	5","2012-9,97	6","2012-9,97	1000","2012-9,99	7","2012-9,99	7"}
#data = {"2012-9,7	1","2012-9,7	1","2012-9,7	1"}

#lastkey = None
#current = 0
    
#for line in data:
#    line = line.strip()
#    key, value = line.split('\t')
#    try:
#        value = int(value)
#        if key != lastkey:
#            if lastkey is not None:
#                print ('%s\t%d' % (lastkey, current))
#            lastkey = key
#            current = 0
#        current += value
#    except ValueError:
#        pass

#if lastkey is not None:
#    print ('%s\t%d' % (lastkey,current))

