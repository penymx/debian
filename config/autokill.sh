#!/bin/bash
# Created By Ahmad Thoriq Najahi
# Dilarang Keras Mengambil/mencuplik/mengcopy sebagian atau seluruh script ini.
# Hak Cipta speedwushssh.net (Dilindungi Undang-Undang nomor 19 Tahun 2002)

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`

MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com)

PARAM=$1

echo -n > /tmp/pid2
ps ax|grep dropbear > /tmp/pid
cat /tmp/pid | grep -i 'dropbear -p' > /tmp/pids
cat /var/log/auth.log |  grep -i "Password auth succeeded" > /tmp/sks
perl -pi -e 's/Password auth succeeded for//g' /tmp/sks
perl -pi -e 's/dropbear//g' /tmp/sks

cat /tmp/pid | while read line;do
	set -- $line
	p=$1
	var=`cat /tmp/sks | grep -i $1`
	set -- $var
	l=$6
	if [ "$6" != '' ]; then
		echo "$p $l" | cat - /tmp/pid2 > /tmp/temp && mv /tmp/temp /tmp/pid2
	fi
done

case $PARAM in
1)
	echo -n > /tmp/user1
	cat /tmp/pid2 | while read line;do
		set -- $line
		p=$1
		u=$2
		cat /tmp/user1 | grep -i $u > /dev/null
		if [ $? = 1 ]; then
			echo $line >> /tmp/user1
		else
			kill $p
			echo "kill $p user $u"
		fi
	done
	rm -f /tmp/pid
	rm -f /tmp/pid2
	rm -f /tmp/pids
	rm -f /tmp/sks
	rm -f /tmp/user1
	exit 0
;;
2)
	echo -n > /tmp/user1
	echo -n > /tmp/user2
	cat /tmp/pid2 | while read line;do
		set -- $line
		p=$1
		u=$2
		cat /tmp/user1 | grep -i $u > /dev/null
		if [ $? = 1 ]; then
			echo $line >> /tmp/user1
		else
			cat /tmp/user2 | grep -i $u > /dev/null
			if [ $? = 1 ]; then
				echo $line >> /tmp/user2
			else
				kill $p
				echo "kill $p user $u"
			fi
		fi
	done
	rm -f /tmp/pid
	rm -f /tmp/pid2
	rm -f /tmp/pids
	rm -f /tmp/sks
	rm -f /tmp/user1
	rm -f /tmp/user2
	exit 0
;;
*)
	echo " Gunakan perintah user-limit 1 untuk limit 1 login saja"
	echo " atau user-limit 2  untuk melimit max 2 login"
	rm -f /tmp/pid
	rm -f /tmp/pid2
	rm -f /tmp/pids
	rm -f /tmp/sks
	exit 1
;;
esac

service dropbear restart
