#!/bin/sh

chmod +x task2/*.expect
chmod +x task2/*.sh

ssh asn4.facchinetti-bgp.offtech "sudo apt install expect -y"
ssh asn4.facchinetti-bgp.offtech "bgp/task2/task2_asn4.expect; bgp/task2/task2_asn4_setup.sh"

read  -p "Please wait 5 mins before pressing anything" temp
