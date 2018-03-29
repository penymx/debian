#!/bin/bash

#Cek Curl
if [ ! -e /usr/bin/curl ]; then
	if [[ "$OS" = 'debian' ]]; then
	apt-get -y update && apt-get -y install curl
	else
	yum -y update && yum -y install curl
	fi
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
rm -f /tmp/opensshport


if [[ "$OS" = 'debian' ]]; then
	cd
	read -p "Masukkan port OpenSSH yang dipisahkan dengan 'spasi': " port
	opensshport="$(netstat -ntlp | grep -i ssh | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

	#Display & Delete Old OpenSSH Port
	echo ""
	echo -e "\e[34;1mPort OpenSSH sebelum diedit:\e[0m"
	cat > /root/opensshport <<-END
	$opensshport
	END

	exec</root/opensshport
	while read line
	do
		echo "Port $line"
		sed "/Port $line/d" -i /etc/ssh/sshd_config
	done
	rm -f /root/opensshport

	echo ""

	#Add New Port
	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i ssh | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				sed -i "4 a\Port $i" /etc/ssh/sshd_config
				echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
			fi
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk Dropbear\e[0m"
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
			sed -i "4 a\Port $i" /etc/ssh/sshd_config
			echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
		fi
	done

	echo ""
	service ssh restart > /dev/null
	sleep 0.5
	#Display New Port
	rm -f /root/opensshport
	opensshport="$(netstat -nlpt | grep -i sshd | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort OpenSSH sesudah diedit:\e[0m"
	cat > /root/opensshport <<-END
	$opensshport
	END
	exec</root/opensshport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/opensshport
else 
#######################################################################################################################################
#Jika Centos
	cd
	read -p "Masukkan port OpenSSH yang dipisahkan dengan 'spasi': " port
	opensshport="$(netstat -ntlp | grep -i ssh | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

	#Display & Delete Old OpenSSH Port
	echo ""
	echo -e "\e[34;1mPort OpenSSH sebelum diedit:\e[0m"
	cat > /root/opensshport <<-END
	$opensshport
	END

	exec</root/opensshport
	while read line
	do
		echo "Port $line"
		sed "/Port $line/d" -i /etc/ssh/sshd_config
	done
	rm -f /root/opensshport

	echo ""

	#Add New Port
	for i in ${port[@]}
	do
		netstat -nlpt | grep -w "$i" > /dev/null
		if [ $? -eq 0 ]; then
			netstat -nlpt | grep -i ssh | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				sed -i "12 a\Port $i" /etc/ssh/sshd_config
				echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
			fi
			netstat -nlpt | grep -i dropbear | grep -w "$i" > /dev/null
			if [ $? -eq 0 ]; then
				echo -e "\e[031;1mPort $i gagal ditambahkan. Port $i sudah digunakan untuk Dropbear\e[0m"
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
			sed -i "12 a\Port $i" /etc/ssh/sshd_config
			echo -e "\e[032;1mPort $i berhasil ditambahkan\e[0m"
		fi
	done

	echo ""
	service sshd restart > /dev/null
	sleep 0.5
	#Display New Port
	rm -f /root/opensshport
	opensshport="$(netstat -nlpt | grep -i sshd | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo ""
	echo -e "\e[34;1mPort OpenSSH sesudah diedit:\e[0m"
	cat > /root/opensshport <<-END
	$opensshport
	END
	exec</root/opensshport
	while read line
	do
		echo "Port $line"
	done
	rm -f /root/opensshport
fi
cd