#!/bin/sh

chmod +x *.sh

if [ -f "task"$1"/task"$1".sh" ]; then
    sh "./task"$1"/task"$1".sh"
fi

ssh client.facchinetti-bgp.offtech "bgp/client.sh $1"
ssh asn2.facchinetti-bgp.offtech "bgp/asn2.sh $1"
ssh asn3.facchinetti-bgp.offtech "bgp/asn3.sh $1"
