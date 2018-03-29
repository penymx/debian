#!/bin/bash

#Cek Curl
if [ ! -e /usr/bin/curl ]; then
	if [[ "$OS" = 'debian' ]]; then
	apt-get -y update && apt-get -y install curl
	else
	yum -y update && yum -y install curl
	fi
fi

#Cek ROOT
if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

#Cek OS
if [[ -e /etc/debian_version ]]; then
	OS=debian
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
else
	echo "Sepertinya Anda tidak menjalankan script ini pada sistem Debian, Ubuntu atau CentOS"
	exit
fi

#Remove Temporary Files
rm -f /root/dropbearport

if [[ "$OS" = 'debian' ]]; then
	read -p "Masukkan Port Dropbear yang dipisahkan dengan 'spasi': " port
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear sebelum diedit:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
		#sed "s/Port $line//g" -i /etc/default/dropbear
	done
	rm -f /root/dropbearport

	sed '/DROPBEAR_PORT/d' -i /etc/default/dropbear
	sed '/DROPBEAR_EXTRA_ARGS/d' -i /etc/default/dropbear

	echo ""

	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -n "-p $i " >> /root/dropbearport
				echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
			fi
			
			netstat -nlpt | grep -i sshd | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk Squid\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk OpenVPN\e[0m"
			fi
		else
			echo -n "-p $i " >> /root/dropbearport
			echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
		fi
	done

	DROPBEAR_PORT="$(cat /root/dropbearport | awk '{print $2}')"
	sed -i "5 a\DROPBEAR_PORT=$DROPBEAR_PORT" /etc/default/dropbear

	while read line
	do
		echo "Port $line"
	done < "/root/dropbearport"
	sed -i "8 a\DROPBEAR_EXTRA_ARGS=\"$line\"" /etc/default/dropbear

	echo ""
	service dropbear restart > /dev/null
	sleep 0.5
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear sesudah diedit:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/dropbearport
else
	read -p "Masukkan Port Dropbear yang dipisahkan dengan 'spasi': " port
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear sebelum diedit:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
		#sed "s/Port $line//g" -i -i /etc/sysconfig/dropbear
	done
	rm -f /root/dropbearport
	sed '/OPTIONS=/d' -i /etc/sysconfig/dropbear
	echo ""

	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -n "-p $i " >> /root/dropbearport
				echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
			fi
			
			netstat -nlpt | grep -i sshd | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk OpenSSH\e[0m"
			fi
			
			netstat -nlpt | grep -i squid | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk Squid\e[0m"
			fi
			
			netstat -nlpt | grep -i openvpn | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk OpenVPN\e[0m"
			fi
		else
			echo -n "-p $i " >> /root/dropbearport
			echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
		fi
	done

	DROPBEAR_PORT="$(cat /root/dropbearport)"
	echo "OPTIONS=\"$DROPBEAR_PORT\"" > /etc/sysconfig/dropbear
	echo ""
	service dropbear restart > /dev/null
	sleep 0.5
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort Dropbear sesudah diedit:\e[0m"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/dropbearport
fi
cd