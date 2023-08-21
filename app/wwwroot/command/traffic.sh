sudo nethogs -j -d 1 -v 3 -c 30 | grep  ' ' -n > /root/app/wwwroot/files/trafficUser$1.json
#sudo nethogs  -j -d 1 -v 3 -c 30  | grep  '' -n > /root/panel/wwwroot/files/trafficUser$1.json