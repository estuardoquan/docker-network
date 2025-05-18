# Docker Network

Quick reminder of how the docker `ipvlan` network driver works.

## ipvlan l2

Quick example:

```
$ docker network create -d ipvlan \
    --subnet 192.168.1.0/24 \
    --gateway 192.168.1.1 
    --ip-range 192.168.1.128/25 \
    -o ipvlan_mode=l2 \
    -o parent=eth0 \
    ipvlan_network
```

in summary; 

`-d` or `--driver`  : to set network mode as `ipvlan`.
`--gateway`         : is the router's ip address and can be found via the `ip` (or `ifconfig`) command on linux distros.
`--subnet`          : These ip/mask combo refers to the subnet on which the device we're trying attach resides.
`-o ipvlan_mode=l2` : multiple ipvlan modes exist and will be reviewed moving forward.
`-o parent=eth0`    : Naming on linux can vary from `eth0`, `wlan0` to `enp1s0`, `wlp2s0` for ethernet and wirless respectively. 
                        **worth looking into**
                        // Mac, or BSD network interfaces are named after 
                        // the device driver that manages the interface.

