
#Load info about wiring, drop any empty line and store it in file
echo "Retrieving data about wired connections...."
#Using ";" as new separator so that they can be loaded as env varibales.
/share/shared/Internetworking/showcabling Facchinetti-Inetwor offtech | sed 's/ <- is "wired" to -> /;/' | grep -v -e '^[[:space:]]*$' > wiring.txt

cat wiring.txt

echo "Parsing retrieved data...."

#Parse info for every line and maaking it look easy to understand
cat wiring.txt | grep NWworkstation1 | sed 's/workstation1 /W_SIF=/' | sed 's/router /R_NIF=/' >> nics.sh
cat wiring.txt | grep NWrouter | grep ISrouter | sed 's/NWrouter /NWR_SIF=/' | sed 's/ISrouter /ISR_NIF=/' >> nics.sh
cat wiring.txt | grep SWrouter | grep ISrouter | sed 's/ISrouter /ISR_SIF=/' | sed 's/SWrouter /SWR_NIF=/' >> nics.sh
cat wiring.txt | grep SWworkstation1 | sed 's/workstation1 /W_NIF=/' | sed 's/router /R_SIF=/' >> nics.sh

echo "Loading data...."
source nics.sh

NETMASK=255.255.255.248

echo "Generating setup files..."
cat << EOF > setup_nww.sh

#!/bin/bash
ifconfig ${NWW_SIF} 10.0.1.2 netmask ${NETMASK}

route add -net 10.0.2.0 netmask ${NETMASK} gw 10.0.1.1 ${NWW_SIF}
route add -net 1.0.0.0 netmask ${NETMASK} gw 10.0.1.1 ${NWW_SIF}
route add -net 2.0.0.0 netmask ${NETMASK} gw 10.0.1.1 ${NWW_SIF}

ifconfig ${NWW_SIF} up

EOF

cat << EOF > setup_nwr.sh

#!/bin/bash
ifconfig ${NWR_NIF} 10.0.1.1 netmask ${NETMASK}
ifconfig ${NWR_SIF} 1.0.0.1 netmask ${NETMASK}

route add -net 2.0.0.0 netmask ${NETMASK} gw 1.0.0.2 ${NWR_SIF}
route add -net 10.0.2.0 netmask ${NETMASK} gw 1.0.0.2 ${NWR_SIF}

iptables -t nat -A POSTROUTING -o ${NWR_SIF} -s 10.0.1.0/29 -j SNAT --to 1.0.0.1

ifconfig ${NWR_NIF} up
ifconfig ${NWR_SIF} up

EOF

cat << EOF > setup_isr.sh

#!/bin/bash
ifconfig ${ISR_NIF} 1.0.0.2 netmask ${NETMASK}
ifconfig ${ISR_SIF} 2.0.0.2 netmask ${NETMASK}

ifconfig ${ISR_NIF} up
ifconfig ${ISR_SIF} up

iptables -I FORWARD -d 192.168.0.0/16 -j DROP
iptables -I FORWARD -d 172.16.0.0/12 -j DROP
iptables -I FORWARD -d 10.0.0.0/8 -j DROP
iptables -I FORWARD -s 192.168.0.0/16 -j DROP
iptables -I FORWARD -s 172.16.0.0/12 -j DROP
iptables -I FORWARD -s 10.0.0.0/8 -j DROP

EOF

cat << EOF > setup_swr.sh

#!/bin/bash
ifconfig ${SWR_NIF} 2.0.0.1 netmask ${NETMASK}
ifconfig ${SWR_SIF} 10.0.2.1 netmask ${NETMASK}

route add -net 1.0.0.0 netmask ${NETMASK} gw 2.0.0.2 ${SWR_NIF}
route add -net 10.0.1.0 netmask ${NETMASK} gw 2.0.0.2  ${SWR_NIF}

iptables -t nat -A POSTROUTING -o ${SWR_NIF} -s 10.0.2.0/29 -j SNAT --to 2.0.0.1

iptables -t nat -A PREROUTING -i ${SWR_NIF} -d 2.0.0.1/32 -p tcp --dport 80 -j DNAT --to 10.0.2.2

ifconfig ${SWR_NIF} up
ifconfig ${SWR_SIF} up

EOF

cat << EOF > setup_sww.sh

#!/bin/bash
ifconfig ${SWW_NIF} 10.0.2.2 netmask ${NETMASK}

route add -net 10.0.1.0 netmask ${NETMASK} gw 10.0.2.1 ${SWW_NIF}
route add -net 1.0.0.0 netmask ${NETMASK} gw 10.0.2.1 ${SWW_NIF}
route add -net 2.0.0.0 netmask ${NETMASK} gw 10.0.2.1 ${SWW_NIF}

ifconfig ${SWW_NIF} up

EOF

#Apply files
echo "Applying files..."
chmod +x setup_*.sh

echo "Configuring NWworkstation1...";
ssh NWworkstation1.Facchinetti-Inetwor.offtech "sudo su -c ./internetworking/setup_nww.sh"
echo "NWworkstation1 configured; moving to SWworkstation1..."
ssh SWworkstation1.Facchinetti-Inetwor.offtech "sudo su -c ./internetworking/setup_sww.sh"
echo "SWworkstation1 configured; moving to NWrouter..."
ssh NWrouter.Facchinetti-Inetwor.offtech "sudo su -c ./internetworking/setup_nwr.sh"
echo "NWrouter configured; moving to SWrouter..."
ssh SWrouter.Facchinetti-Inetwor.offtech "sudo su -c ./internetworking/setup_swr.sh"
echo "SWrouter configured; moving to ISrouter..."
ssh ISrouter.Facchinetti-Inetwor.offtech "sudo su -c ./internetworking/setup_isr.sh"
echo "ISrouter configured; done!"
