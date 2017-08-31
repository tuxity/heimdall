#! /usr/bin/env bash

# iptables -t nat -A PREROUTING -p tcp --dest 127.0.0.1  --dport 1111 -j DNAT --to-destination 127.0.0.1:2222
# iptables -t nat -A POSTROUTING -p tcp --dest ${rule.dest_ip} --dport ${rule.dest_port} -j SNAT --to-source ${rule.src_ip}
