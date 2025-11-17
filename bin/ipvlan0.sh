#!/bin/sh

DEV=${1:-ipvlan0}
INT=${2:?'Error: Please provide interface'}
ADDR=${3:?'Please provide address'}

ip link add ${DEV} link ${INT} type ipvlan mode l2
ip addr add ${ADDR} dev ${DEV}
ip link set ${DEV} up
