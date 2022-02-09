#!/usr/bin/env sh

if [ "$EUID" -ne 0 ]
  then echo "The current user must be root!"
  exit
fi

# The UDP-port of OpenVPN
_trans_port="1194"
# Tunnel adapter
_int_if="tun0"
# Listen address:port by Tor server
_ip_listen="127.0.0.1:9050"

# Wrap OpenVPN traffic into Tor
iptables -A INPUT -i $_int_if -m state --state NEW -j ACCEPT
iptables -t nat -A PREROUTING -i $_int_if -p udp --dport 53 -j DNAT --to-destination 127.0.0.1:53530
iptables -t nat -A PREROUTING -i $_int_if -p tcp -j DNAT --to-destination $_ip_listen
iptables -t nat -A PREROUTING -i $_int_if -p udp -j DNAT --to-destination $_ip_listen

