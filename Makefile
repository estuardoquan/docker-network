DEV=wlp3s0
NAME=ipvlan_network

GATEWAY=192.168.1.1
RANGE=192.168.1.128/25
SUBNET=192.168.1.0/24


all:

ipvlan_l2:
	docker network create -d ipvlan \
		--gateway ${GATEWAY} \
		--ip-range ${RANGE} \
		--subnet ${SUBNET} \
		-o ipvlan_mode=l2 \
		-o parent=${DEV} \
		${NAME}
