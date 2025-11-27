ADDR=10.0.0.64
DEV=ipvlan0
INT=enp2s0
MASK=24
GATEWAY=10.0.0.1
RANGE=${ADDR}/26
SUBNET=10.0.0.0/${MASK}

all:

install_%:
	sh -c "./ipvlan.sh network ${ADDR} ${INT} > /bin/$<"

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



