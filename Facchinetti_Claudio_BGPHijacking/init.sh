#!/bin/sh

# Remove default routes on asn2 and asn3
ssh asn2.facchinetti-bgp.offtech sudo ip route del 10.1.1.0/24
ssh asn3.facchinetti-bgp.offtech sudo ip route del 10.1.1.0/24
