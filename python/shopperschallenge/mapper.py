#!/usr/bin/python

import sys
import datetime

for line in sys.stdin:
    line=line.split(",")
    if line[0] != "":
        line[0] = line[0][:4] + '-'+ str(datetime.date(int(line[0][:4]), int(line[0][5:7]), int(line[0][8:10])).isocalendar()[1])
        print('%s\t%d' % (line[0]+','+line[1], int(line[2])))



##--------------------------------------------------------------------------------------
##test:

#import sys
#import datetime
#data = ["2012-03-02,7,1","2012-03-02,63,1","2012-03-02,97,1","2012-03-02,25,1","2012-03-02,55,2","2012-03-02,97,1","2012-03-02,99,1","2012-03-02,59,1"]

#for line in data:
#    line=line.split(",")
#    if line[0] != "":
#        line[0] = line[0][:4] + '-'+ str(datetime.date(int(line[0][:4]), int(line[0][5:7]), int(line[0][8:10])).isocalendar()[1])
#        print('%s\t%d' % (line[0]+','+line[1], int(line[2])))