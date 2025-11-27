ADDR=10.0.0.64
INT=enp2s0
MASK=24
GATEWAY=10.0.0.1
RANGE=${ADDR}/26
SUBNET=10.0.0.0/${MASK}

all:

install_%:
	./ipvlan.sh check $* || \
	echo "Unable to create files" && \
	sh -c "./ipvlan.sh network -d $* -m ${MASK} ${ADDR} ${INT} > ./test/$*"

ipvlan_network:
	docker network create -d ipvlan \
		--gateway ${GATEWAY} \
		--ip-range ${RANGE} \
		--subnet ${SUBNET} \
		-o ipvlan_mode=l2 \
		-o parent=${INT} \
		${@}

macvlan_network:
	docker network create -d ipvlan \
		--gateway ${GATEWAY} \
		--ip-range ${RANGE} \
		--subnet ${SUBNET} \
		-o parent=${INT} \
		${@}



