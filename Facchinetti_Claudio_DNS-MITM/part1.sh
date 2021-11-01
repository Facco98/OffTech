#!/bin/sh
ssh client.facchinetti-dns.offtech "dig www.google.com A > dns/part1_client.txt"
cat part1_client.txtrm