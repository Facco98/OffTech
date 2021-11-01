#!/bin/sh

ssh auth.facchinetti-dns.offtech "sudo dns/part4_auth.sh"
ssh cache.facchinetti-dns.offtech "sudo dns/part4_cache.sh"
ssh client.facchinetti-dns.offtech "dig +dnssec www.google.com A > dns/part4_client.txt"

cat part4_client.txt