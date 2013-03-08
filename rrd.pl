#!/usr/bin/perl

use strict;

use RRDs;
use Data::Dumper;
use LWP::UserAgent;
use Log::Log4perl qw{ :easy };

Log::Log4perl->easy_init($DEBUG);

my $metar_url = 'http://weather.noaa.gov/pub/data/observations/metar/stations/LFQQ.TXT';
my $refreshOutTime = 600; # 10min
my $limitOutTime = $refreshOutTime*2; # 20min
my $script = "/home/henri/sensor";
my $rrdFile = '/home/henri/climate/hometemp.rrd';
my %out;

DEBUG "$0 initialization, start loop";

while (1)
{
    DEBUG "wait 10 sec";
    sleep 10;
    my %values;

    DEBUG "call $script";
    my $sensor = `$script`;
    chomp($sensor);
    DEBUG "get $sensor";

    if ($?)
    {
        WARN "Error : $script finished abnormally\n";
        next;
    }
    elsif ($sensor !~ /^Humidity = ([\d\.]+)% Temperature = ([\d\.]+)°C/)
    {
        WARN "Error : invalid data, does not match";
        next;
    }

    my $humidity    = $1;
    my $temperature = $2;

    if ($out{'time'}+$refreshOutTime < time())
    {
        DEBUG 'refresh out temperature';
        my $response = LWP::UserAgent->new()->get($metar_url);

        if ($response->is_success)
        {
            my $metar = $response->content();
            DEBUG "get metar response : $metar";

            if ($metar !~ /([\s|M])(\d{2})\//g)
            {
                WARN "invalid response";
            }
            else
            {
                $out{'time'} = time();
                $out{'temp'} = ($1 eq 'M') ? $2 * -1 : $2;
            }
        }
        else
        {
            INFO "http response invalid";
        }

        if ($out{'time'}+$limitOutTime < time()) # considere out-of-date
        {
            WARN "out temperature out-of-date, do not keep value on rrd";
            delete($out{'temp'})
        }
    }

    DEBUG "set $rrdFile with N:$temperature:$out{'temp'}:$humidity";

    RRDs::update($rrdFile, "N:$temperature:$out{'temp'}:$humidity");
    if (my $error = RRDs::error())
    {
        die "Error while updating RRD: $error";
    }
}
