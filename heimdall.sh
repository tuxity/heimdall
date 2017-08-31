#! /usr/bin/env bash

iptables=/sbin/iptables

function print_rules() {
  echo "Table nat:"
  $iptables -t nat -S PREROUTING
  $iptables -t nat -S POSTROUTING
}

function add_rule() {
  src_ip=$1
  src_port=$2
  dest_ip=$3
  dest_port=$4

  # Todo: check for tcp/udp
  $iptables -t nat -A PREROUTING -p tcp --dest $src_ip  --dport $src_port -j DNAT --to-destination $dest_ip:$dest_port
  $iptables -t nat -A POSTROUTING -p tcp --dest $dest_ip --dport $dest_port -j SNAT --to-source $src_ip:$src_port

  echo "Traffic from $src_ip:$src_port is now redirected to $dest_ip:$dest_port"
}

function del_rule() {
  src_ip=$1
  src_port=$2
  dest_ip=$3
  dest_port=$4

  $iptables -t nat -D PREROUTING -p tcp --dest $dest_ip  --dport $dest_port -j DNAT --to-destination $src_ip:$src_port
  $iptables -t nat -D POSTROUTING -p tcp --dest $src_ip --dport $src_port -j SNAT --to-source $dest_ip:$src_port

  echo "Remove redirection of Traffic from $src_ip:$src_port to $dest_ip:$dest_port"
}

print_rules
add_rule 127.0.0.1 1111 127.0.0.1 2222
print_rules
del_rule 127.0.0.1 1111 127.0.0.1 2222
print_rules
