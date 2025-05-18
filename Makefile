DEV=enp2s0
GATEWAY=179.1.1.1
RANGE=179.1.1.0/26
SUBNET=179.1.1.0/24

all:

ipvlan_network:
	docker network create -d ipvlan \
		--gateway ${GATEWAY} \
		--ip-range ${RANGE} \
		--subnet ${SUBNET} \
		-o ipvlan_mode=l2 \
		-o parent=${DEV} \
		${@}

macvlan_network:
	docker network create -d ipvlan \
		--gateway ${GATEWAY} \
		--ip-range ${RANGE} \
		--subnet ${SUBNET} \
		-o parent=${DEV} \
		${@}



