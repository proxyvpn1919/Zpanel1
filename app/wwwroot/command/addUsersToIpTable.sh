for login in $(cat /root/listu.txt);
do
    iptables -N  $login
    iptables -A OUTPUT -m owner --uid-owner $(id -u $login) -j  $login
done