#!/bin/sh

ETH=eth4

cat << EOF > cl-request.sh
#!/bin/sh
while sleep 1; do
  curl http://5.6.7.8 > /dev/null 2> /dev/null;
done;
EOF

chmod +x cl-request.sh
sudo tcpdump -nn -v -s0 -i ${ETH} -w record.pcap &
./cl-request.sh
