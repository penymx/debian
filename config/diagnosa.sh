#!/bin/bash
# Created by http://www.sshinjector.net
# Dilarang Keras Mengambil/mencuplik/mengcopy sebagian atau seluruh script ini.
# Hak Cipta sshinjector.net (Dilindungi Undang-Undang nomor 19 Tahun 2002)
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Connecting to server..."
sleep 0.2
echo "Checking Permision..."
sleep 0.3
echo -e "${green}Permission Accepted...${NC}"
sleep 1

#inisialisasi
if [[ -e /etc/debian_version ]]; then
	OS=Debian
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=Centos
else
	echo "Mohon maaf, script ini hanya untuk debian/centos"
	exit
fi
if $(uname -m | grep '64'); then
  arch='64 bit'
else
  arch='32 bit'
fi
echo "SOLUSI" > /var/tmp/solusi.txt

# tun/tap
# if [[ ! -e /dev/net/tun ]]; then
	# echo "TUN/TAP: Tidak Berjalan" > /var/tmp/hasil-tuntap.txt
	# echo "- Enable Tun/TAP pada VPS Panel. Jika ternyata sudah enabled, tekan disable, tunggu 5 menit, tekan enable lagi" >> /var/tmp/solusi.txt
	# else
	# echo "TUN/TAP: Normal" > /var/tmp/hasil-tuntap.txt
# fi

# ppp
# if [[ ! -e /dev/ppp ]]; then
	# echo "PPP: Tidak Berjalan" > /var/tmp/hasil-ppp.txt
	# echo "- Enable PPP pada VPS Panel. Jika ternyata sudah enabled, tekan disable, tunggu 5 menit, tekan enable lagi" >> /var/tmp/solusi.txt
	# else
	# echo "PPP: Normal" > /var/tmp/hasil-ppp.txt
# fi

#OpenSSH
netstat -ntlp | grep ssh | awk '{print $4}' | cut -d ":" -f 2 > /var/tmp/openssh.txt
if [[ -s /var/tmp/openssh.txt ]] ; then
cat /var/tmp/openssh.txt  | xargs | sed -e 's/ /,/g' > /var/tmp/openssh2.txt
portopenssh=`cat /var/tmp/openssh2.txt`
echo "OpenSSH: Normal. Berlajan di Port $portopenssh" > /var/tmp/hasil-openssh.txt
else
echo "OpenSSH: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-openssh.txt
if [[ -e /etc/debian_version ]]; then
		echo "- Ketik service ssh restart pada putty" >> /var/tmp/solusi.txt
else [[ -e /etc/centos-release || -e /etc/redhat-release ]];
		echo "- Ketik service sshd restart pada putty" >> /var/tmp/solusi.txt
fi
fi

#Dropbear
netstat -ntlp | grep dropbear | awk '{print $4}' | cut -d ":" -f 2 > /var/tmp/dropbear.txt
if [[ -s /var/tmp/dropbear.txt ]] ; then
cat /var/tmp/dropbear.txt | xargs | sed -e 's/ /,/g' > /var/tmp/dropbear2.txt
portdropbear=`cat /var/tmp/dropbear2.txt`
echo "Dropbear: Normal. Berlajan di Port $portdropbear" > /var/tmp/hasil-dropbear.txt
else
echo "Dropbear: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-dropbear.txt
echo "- Ketik service dropbear restart pada putty" >> /var/tmp/solusi.txt
fi

#Squid Proxy
netstat -ntlp | grep squid | awk '{print $4}' | cut -d ":" -f 4 > /var/tmp/squid.txt
if [[ -s /var/tmp/squid.txt ]] ; then
cat /var/tmp/squid.txt | xargs | sed -e 's/ /,/g' > /var/tmp/squid2.txt
portsquid=`cat /var/tmp/squid2.txt`
echo "Squid: Normal. Berlajan di Port $portsquid" > /var/tmp/hasil-squid.txt
else
echo "Squid: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-squid.txt
if [[ -e /etc/debian_version ]]; then
		echo "- Ketik service squid3 restart pada putty" >> /var/tmp/solusi.txt
else [[ -e /etc/centos-release || -e /etc/redhat-release ]];
		echo "- Ketik service squid restart pada putty" >> /var/tmp/solusi.txt
fi
fi

#OpenVPN
netstat -ntlp | grep openvpn | awk '{print $4}' | cut -d ":" -f 2 > /var/tmp/openvpn.txt
if [[ -s /var/tmp/openvpn.txt ]] ; then
cat /var/tmp/openvpn.txt | xargs | sed -e 's/ /,/g' > /var/tmp/openvpn2.txt
portopenvpn=`cat /var/tmp/openvpn2.txt`
echo "OpenVPN: Normal. Berlajan di Port $portopenvpn" > /var/tmp/hasil-openvpn.txt
else
echo "OpenVPN: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-openvpn.txt
echo "- Ketik service openvpn restart pada putty" >> /var/tmp/solusi.txt
echo "(Apabila muncul tulisan no such device saat openvpn di restart, silahkan disable Tun/Tap lalu enable lagi" >> /var/tmp/solusi.txt
fi

#Webmin
netstat -ntlp | grep 10000 | awk '{print $4}' | cut -d ":" -f 2 > /var/tmp/webmin.txt
if [[ -s /var/tmp/webmin.txt ]] ; then
cat /var/tmp/webmin.txt | xargs | sed -e 's/ /,/g' > /var/tmp/webmin2.txt
portwebmin=`cat /var/tmp/webmin2.txt`
echo "Webmin: Normal. Berlajan di Port $portwebmin" > /var/tmp/hasil-webmin.txt
else
echo "Webmin: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-webmin.txt
echo "- Ketik service webmin restart pada putty" >> /var/tmp/solusi.txt
fi

#nginx 
netstat -ntlp | grep nginx | awk '{print $4}' | cut -d ":" -f 2 > /var/tmp/nginx.txt
if [[ -s /var/tmp/nginx.txt ]] ; then
cat /var/tmp/nginx.txt | xargs | sed -e 's/ /,/g' > /var/tmp/nginx2.txt
portnginx=`cat /var/tmp/nginx2.txt`
echo "nginx: Normal. Berlajan di Port $portnginx" > /var/tmp/hasil-nginx.txt
else
echo "nginx: Tidak Normal. (Tidak Berjalan)" > /var/tmp/hasil-nginx.txt
echo "- Ketik service nginx restart pada putty" >> /var/tmp/solusi.txt
fi

echo "Diagnosa VPS Otomatis"
echo "(Created By sshinjector.net)"
echo "-------------------------------------------"
echo "PENGECEKAN INTERFACE"
echo " "
echo "Operating System: $OS"
echo "Architechture: $arch"
echo "-------------------------------------------"
echo "PENGECEKAN APLIKASI"
echo " "
cat /var/tmp/hasil-openssh.txt
cat /var/tmp/hasil-dropbear.txt
cat /var/tmp/hasil-squid.txt
cat /var/tmp/hasil-openvpn.txt
cat /var/tmp/hasil-webmin.txt
cat /var/tmp/hasil-nginx.txt
echo "-------------------------------------------"
cat /var/tmp/solusi.txt
echo "-------------------------------------------"
echo "Apakah Anda mau menjalankan auto-fix? "
echo "1) Ya"
echo "2) Tidak"
read -p "Tulis Pilihan Anda (angka): " x
if test $x -eq 1; then
if [[ -e /etc/debian_version ]]; then
service nginx start
service php5-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service stunnel4 restart
service squid3 restart
service webmin restart


else [[ -e /etc/centos-release || -e /etc/redhat-release ]];
service nginx start
service php-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service sshd restart
service dropbear restart
service fail2ban restart
service squid restart
service webmin restart
service pptpd restart
service crond start

fi
echo "Diagnosa VPS Otomatis"
echo "(Created By Ahmad Thoriq Najahi)"
echo "-------------------------------------------"
echo "Proses Auto Fix Telah Selesai."
# runs this if option 2 is selected
elif test $x -eq 2; then
exit
else
echo "Pilihan tidak terdapat di menu."
exit
fi
