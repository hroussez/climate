#!/bin/bash
PNGDIR="/dev/shm/climate"
RRDDIR="/home/henri/climate"

#set to C if using Celsius
TEMP_SCALE="C"

#define the desired colors for the graphs
INTEMP_COLOR="#CC0000"
OUTTEMP_COLOR="#0000FF"

[ -d "$PNGDIR" ] || mkdir "$PNGDIR"

#hourly
rrdtool graph $PNGDIR/temp_hourly.png --start -4h -t "Hourly temperature"\
    DEF:temp=$RRDDIR/hometemp.rrd:temp:AVERAGE \
    AREA:temp$INTEMP_COLOR:"Inside Temperature [deg $TEMP_SCALE]" \
    DEF:outtemp=$RRDDIR/hometemp.rrd:outtemp:AVERAGE \
    LINE1:outtemp$OUTTEMP_COLOR:"Outside Temperature [deg $TEMP_SCALE]" || exit

rrdtool graph $PNGDIR/humidity_hourly.png --start -4h -t "Hourly humidity"\
    DEF:humidity=$RRDDIR/hometemp.rrd:humidity:AVERAGE \
    AREA:humidity$INTEMP_COLOR:"Inside humidity [ % ]" || exit

#daily
rrdtool graph $PNGDIR/temp_daily.png --start -1d -t "Daily temperature"\
    DEF:temp=$RRDDIR/hometemp.rrd:temp:AVERAGE \
    AREA:temp$INTEMP_COLOR:"Inside Temperature [deg $TEMP_SCALE]" \
    DEF:outtemp=$RRDDIR/hometemp.rrd:outtemp:AVERAGE \
    LINE1:outtemp$OUTTEMP_COLOR:"Outside Temperature [deg $TEMP_SCALE]" || exit

rrdtool graph $PNGDIR/humidity_daily.png --start -1d -t "Hourly humidity"\
    DEF:humidity=$RRDDIR/hometemp.rrd:humidity:AVERAGE \
    AREA:humidity$INTEMP_COLOR:"Inside humidity [ % ]" || exit

#weekly
rrdtool graph $PNGDIR/temp_weekly.png --start -1w -t "Weekly temperature"\
    DEF:temp=$RRDDIR/hometemp.rrd:temp:AVERAGE \
    DEF:outtemp=$RRDDIR/hometemp.rrd:outtemp:AVERAGE \
    AREA:temp$INTEMP_COLOR:"Inside Temperature [deg $TEMP_SCALE]" \
    LINE1:outtemp$OUTTEMP_COLOR:"Outside Temperature [deg $TEMP_SCALE]" || exit

rrdtool graph $PNGDIR/humidity_weekly.png --start -1w -t "Hourly humidity"\
    DEF:humidity=$RRDDIR/hometemp.rrd:humidity:AVERAGE \
    AREA:humidity$INTEMP_COLOR:"Inside humidity [ % ]" || exit

#monthly
rrdtool graph $PNGDIR/temp_monthly.png --start -1m -t "Monthly temperature"\
    DEF:temp=$RRDDIR/hometemp.rrd:temp:AVERAGE \
    DEF:outtemp=$RRDDIR/hometemp.rrd:outtemp:AVERAGE \
    AREA:temp$INTEMP_COLOR:"Inside Temperature [deg F]" \
    LINE1:outtemp$OUTTEMP_COLOR:"Outside Temperature [deg F]" || exit

rrdtool graph $PNGDIR/humidity_monthly.png --start -1m -t "Hourly humidity"\
    DEF:humidity=$RRDDIR/hometemp.rrd:humidity:AVERAGE \
    AREA:humidity$INTEMP_COLOR:"Inside humidity [ % ]" || exit

#yearly
rrdtool graph $PNGDIR/temp_yearly.png --start -1y -t "Yearly temperature"\
    DEF:temp=$RRDDIR/hometemp.rrd:temp:AVERAGE \
    DEF:outtemp=$RRDDIR/hometemp.rrd:outtemp:AVERAGE \
    AREA:temp$INTEMP_COLOR:"Inside Temperature [deg $TEMP_SCALE]" \
    LINE1:outtemp$OUTTEMP_COLOR:"Outside Temperature [deg $TEMP_SCALE]" || exit

rrdtool graph $PNGDIR/humidity_yearly.png --start -1y -t "Hourly humidity"\
    DEF:humidity=$RRDDIR/hometemp.rrd:humidity:AVERAGE \
    AREA:humidity$INTEMP_COLOR:"Inside humidity [ % ]" || exit

