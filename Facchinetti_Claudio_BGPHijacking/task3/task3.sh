#!/bin/sh


chmod +x task3/*.expect
chmod +x task3/*.sh

ssh asn4.facchinetti-bgp.offtech "sudo apt install expect -y"
ssh asn4.facchinetti-bgp.offtech "bgp/task3/task3_asn4.expect"

read  -p "Wait five minutes and then hit Return" temp

