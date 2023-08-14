iptables -N  $1
iptables -A OUTPUT -m owner --uid-owner $(id -u $1) -j  $1