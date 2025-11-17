#!/bin/sh

ADDR=192.68.1.64/24
DEV=ipvlan0
INT=enp2s0

OPTIONS="a:d:i:"
LONGOPTIONS="addr:,dev:,int:"

GETOPT=$(getopt -o "${OPTIONS}" --long "${LONGOPTIONS}" -n "$(basename "$0")" -- "${@}")

if [ $? -ne 0 ]; then
        echo "Error parsing options."
        exit 1
fi

eval set -- "${GETOPT}"

while true; do
        case "$1" in
        -a | --addr)
                ADDR="$2"
                shift 2
                ;;
        -d | --dev)
                DEV="$2"
                shift 2
                ;;
        -i | --int)
                INT="$2"
                shift 2
                ;;
        --)
                shift
                break
                ;;
        *)
                echo "Internal error!"
                exit 1
                ;;
        esac
done

ip link add ${DEV} link ${INT} type ipvlan mode l2
ip addr add ${ADDR} dev ${DEV}
ip link set ${DEV} up
