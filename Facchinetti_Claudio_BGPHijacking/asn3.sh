#!/bin/sh
sudo vtysh -c "show ip bgp" > "bgp/task"$1"_asn3_output.txt"