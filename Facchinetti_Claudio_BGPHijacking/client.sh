#!/bin/sh

traceroute -n 10.1.1.2 > "bgp/task"$1"_traceroute.txt"
netstat -rn > "bgp/task"$1"_netstat.txt"

ftp -n 10.1.1.2 <<END_SCRIPT
quote USER anonymous
quote PASS somerandompassword
get README
exit
END_SCRIPT