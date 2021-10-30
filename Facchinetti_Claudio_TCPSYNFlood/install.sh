#!/bin/sh

ssh attacker.facchinetti-synflo.offtech "/share/education/TCPSYNFlood_USC_ISI/install-flooder"
ssh server.facchinetti-synflo.offtech "/share/education/TCPSYNFlood_USC_ISI/install-server;sudo sysctl -w net.ipv4.tcp_syncookies=0; sudo sysctl -w net.ipv4.tcp_max_syn_backlog=10000"
