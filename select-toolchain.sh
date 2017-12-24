#!/bin/bash

configs=()
n=0

echo "available configs:"

for c in config.*
do
    ((n++))
    configs+=($c)
    echo -e "\t$n) $c"
done

if [ $# -eq 0 ]
then
    read choice
else
    choice="$1"
fi

if [ $choice -lt 1 ] || [ $choice -gt $n ]
then
    echo "selected config doesn't exist"
    exit 1
fi

echo ".config -> ${configs[choice - 1]}"
rm -f .config
ln -s ${configs[choice - 1]} .config
