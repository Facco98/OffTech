#!/bin/sh
cd /etc/bind
KEY=$(sudo dnssec-keygen -a DSA -n ZONE -b 768 google.com)
KEY=$KEY".key"

echo "\$INCLUDE /etc/bind/$KEY    ; ZSK" | sudo tee -a google.com

sudo dnssec-signzone -P -x -o google.com google.com

echo "Change \"/etc/bind/google.com\" to \"/etc/bind/google.com.signed\" in the /etc/bind/named.conf.local"
echo "Add the follwing lines to the \"/etc/bind/named.conf.options\" file \\
dnssec-enable yes; \\
dnssec-validation yes; \\
dnssec-lookaside auto;" \\

read -p "Everything done, now please enable dns-sec and add the signed zone; then press enter" temp

sudo rndc reconfig
dig +dnssec www.google.com A
