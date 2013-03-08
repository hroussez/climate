#!/bin/bash

rrdtool create hometemp.rrd --step 60 \
    DS:temp:GAUGE:120:U:U \
    DS:outtemp:GAUGE:600:U:U \
    DS:humidity:GAUGE:120:0:100 \
    RRA:AVERAGE:0.5:1:1440 \
    RRA:AVERAGE:0.5:60:17520
