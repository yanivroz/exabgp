#!/bin/bash

export BGP_LOCAL=$(ip route get 8.8.8.8 | grep -Eo 'src [0-9.]+' | awk '{print $2}')
export BGP_PEER=$(ip route get 8.8.8.8 | grep -Eo 'via [0-9.]+' | awk '{print $2}')

sed -i "s/host_gw/$BGP_PEER/" /etc/exabgp/exabgp.conf
sed -i "s/host_if/$BGP_LOCAL/" /etc/exabgp/exabgp.conf
sed -i "s/container_if/$BGP_LOCAL/" /etc/exabgp/exabgp.conf

exabgp /etc/exabgp/exabgp.conf
