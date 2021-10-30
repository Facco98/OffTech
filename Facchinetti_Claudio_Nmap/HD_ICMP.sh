#!/bin/sh

LAST_BIT=1
LAST_BIT_MAX=254

while [ $LAST_BIT -le $LAST_BIT_MAX ]; do
  ping -c 1 5.6.7.${LAST_BIT}
  LAST_BIT=$((LAST_BIT + 1))
done; > "ping_test_result.txt"
