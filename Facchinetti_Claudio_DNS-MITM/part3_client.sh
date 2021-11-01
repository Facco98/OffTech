#!/bin/sh
ssh client.facchinetti-dns.offtech "dig www.google.com A > dns/part3_client.txt"
cat part3_client.txt