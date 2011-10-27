#!/bin/sh

iptables=`which iptables`
modprobe=`which modprobe`
config=`which ip`
prefix=80


if [ $# -eq 3 ]; then
   
    ${modprobe} ipv6 2>&1 > /dev/null
    ${config} tunnel del nl-ipv6 2>&1 > /dev/null
    ${config} tunnel add nl-ipv6 mode sit remote $1 local $2 ttl 255  2>&1 > /dev/null
    ${config} link set nl-ipv6 up  2>&1 > /dev/null
    ${config} addr add $3/${prefix} dev nl-ipv6  2>&1 > /dev/null
    ${config} route add ::/0 dev nl-ipv6  2>&1 > /dev/null

    ${iptables} -A INPUT  -p icmp --icmp-type 8 -s 0/0 -d $1 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
    ${iptables} -A OUTPUT -p icmp --icmp-type 8 -s $1 -d 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
    ${iptables} -A INPUT  -p icmp --icmp-type 0 -s 0/0 -d $1 -m state --state ESTABLISHED,RELATED -j ACCEPT
    ${iptables} -A OUTPUT -p icmp --icmp-type 0 -s $1 -d 0/0 -m state --state ESTABLISHED,RELATED -j ACCEPT

else

    echo "Syntax is: $0 [server] [local] [ipv6]"
fi



