DEV=enp2s0
GATEWAY=10.0.0.1
RANGE=10.0.0.64/26
SUBNET=10.0.0.0/24

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



