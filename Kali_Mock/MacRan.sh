#!/bin/bash


#Goal of this script is to generate a random Mac address and change it when needed


#Generating a random hex value 
	hex=$(hexdump -vn12 -e'4/4 "%08X" 1 "\n"' /dev/urandom)
	hex=$(echo ${hex:0:12} | sed 's/\(..\)/\1:/g')
	echo ${hex:0:17}

#Acquiring required info
	tmp=$(ip route get "$(host superuser.com | awk 'NR==1 {print $NF}')" | grep -o "dev .* src [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

	IFS='[ ]' read -ra  arr <<< $tmp
		name="${arr[1]}"
		ip="${arr[3]}"
			#Need to add the last 3 hex digits from old one
	read MAC </sys/class/net/$name/address
	echo ${MAC:13:18}
echo 52${hex:2:21}${MAC:13:18}
#Change the Mac
	#sudo bash -c "ip link set dev $name address ${hex:0:17}"
