#!/bin/bash

configs=()
n=0

###
# add all configs to array
#

for c in config.*
do
    configs+=($c)
done

###
# if config is no passed, print usage and list available configs
#

if [ $# -ne 1 ]
then
    echo "usage: ${0} <config_number>"
    echo ""
    echo "supported configs are:"

    for c in "${configs[@]}"
    do
        echo -e "\t$n) `echo $c | cut -f2- -d.`"
        ((n++))
    done

    exit $n
fi

if [ ! -f ${configs[${1}]} ]
then
    echo "config doesn't exist"
    exit 1
fi

echo ".config -> ${configs[${1}]}"
rm -f .config
ln -s ${configs[${1}]} .config
