#!/bin/sh

ip link add ipvlan0 link [INTERFACE] type ipvlan mode l2
ip addr add [IP/SUBNET] dev ipvlan0
ip link set ipvlan0 up
