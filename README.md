# IPVLAN

## Docker Network IPVLAN (L2)

Quick reminder of how the docker `ipvlan` network driver works.

```
$ docker network create -d ipvlan \
    --gateway 192.168.1.1 \ 
    --ip-range 192.168.1.128/25 \
    --subnet 192.168.1.0/24 \
    -o ipvlan_mode=l2 \
    -o parent=eth0 \
    ipvlan_network
```

in summary; 

`-d` or `--driver`  : Docker network mode. Possible values `ipvlan`, `macvlan`.
`--gateway`         : is the router's ip address and can be found via the `ip` (or `ifconfig`) command on linux distros.
`--ip-range`        : Define the number of IPs available.   Example: 
                                                            /25 => 128  (addresses), 
                                                            /26 => 64   (addresses),
                                                            /27 => 32...
`--subnet`          : Define the subnet IP/MASK
`-o ipvlan_mode=l2` : Docker supports multiple `ipvlan` modes. Default is `l2`. Possible values `l2`, `l3` and `l3s`
`-o parent=eth0`    : Naming on linux can vary from `eth0`, `wlan0` to `enp2s0`, `wlp2s0` for ethernet and wirless respectively. 

## IPVLAN L2

By default, the HOST is isolated from the IPVLAN network, therefore there is no connectivity between `HOST / Contianer`. 
For a HOST to be able to communicate with containers on `docker ipvlan` network, HOST's network has to be modified.

For a temporary modification we can run:

```
$ ip link add DEV link INT type ipvlan mode l2
$ ip addr add ADDR/MASK dev DEV
$ ip link set DEV up
```

### ipvlan.sh

`ipvlan.sh` is an easy way to review or run the necesary components for temporary/permanent HOST Network solution.

For more information about `ipvlan.sh`, run:

```
$ ./ipvlan.sh -h
```

To run the exact aformentioned sequence, run:

```
$ ./ipvlan.sh network -r ADDR INT
```

For more information about this command, run:

```
$ ./ipvlan.sh network -h
```

### Permanent HOST IPVLAN L2

To create a permanent solution for the host network, run:

```
$ ./ipvlan network -o /bin/target ADDR INT
$ chmod +x /bin/target
$ ./ipvlan service -o /etc/systemd/system/target.service NAME BIN
$ systemctl enable target.service
```

ATTENTION:
    - Please ensure that the target files do not exist and that there is no active service.
    - To place these files on `root` owned directories `sudo` privileges might be required.


