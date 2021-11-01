#!/bin/sh

ssh client.facchinetti-dns.offtech "ifconfig > dns/part2_client.txt"
ssh cache.facchinetti-dns.offtech "ifconfig > dns/part2_cache.txt"
ssh attacker.facchinetti-dns.offtech "ifconfig > dns/part2_attacker.txt"
ssh auth.facchinetti-dns.offtech "ifconfig > dns/part2_auth.txt"

ssh client.facchinetti-dns.offtech "arp >> dns/part2_client.txt"
ssh cache.facchinetti-dns.offtech "arp >> dns/part2_cache.txt"
ssh attacker.facchinetti-dns.offtech "arp >> dns/part2_attacker.txt"
ssh auth.facchinetti-dns.offtech "arp >> dns/part2_auth.txt"

ssh client.facchinetti-dns.offtech "traceroute 10.1.1.3 >> dns/part2_client.txt"
ssh cache.facchinetti-dns.offtech "traceroute 10.1.2.3 >> dns/part2_cache.txt"

echo "Files generated; name schema is part2_<machine>.txt - eg. part2_client.txt"
