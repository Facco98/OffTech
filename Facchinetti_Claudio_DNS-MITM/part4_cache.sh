#!/bin/sh

echo -e "managed-keys{\n
google.com. initial-key \"<paste_key_here>\";\n
};" | sudo tee -a /etc/bind/managed-keys

dig +dnssec dig google.com dnskey

read -p "Copy the key into the /etc/bind/managed-keys file where you see the <past_key_here> placeholder. Then press enter" temp

echo "include \"/etc/bind/managed-keys\";" | sudo tee -a /etc/bind/named.conf

sudo rndc reconfig

echo "Cache configuration is finished"

