uuid=`nmcli  -f   uuid,device connection  show|grep eth1|awk '{print $1}'`
nmcli connection modify $uuid autoconnect no
#nmcli connection delete $uuid 
ip link set eth1 down
