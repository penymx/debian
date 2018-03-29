               #!/bin/bash
               # Created by http://www.sshinjector.net
               # Dilarang Keras Mengambil/mencuplik/mengcopy sebagian atau seluruh script ini.
               # Hak Cipta sshinjector.net (Dilindungi Undang-Undang nomor 19 Tahun 2002)
               red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
               echo "Connecting to sshinjector.net..."
               sleep 0.2
               echo "Checking Permision..."
               sleep 0.3
               echo -e "${green}Permission Accepted...${NC}"
               sleep 1
               echo""

               if [ ! -f /usr/local/bin/deleteduser ]; then
               echo "echo "Script Created By sshinjector.net"" > /usr/local/bin/deleteduser
               chmod +x /usr/local/bin/deleteduser
               fi
               hariini=`date +%d-%m-%Y`
               echo "Script by sshinjector.net"
               echo "Terimakasih sudah berlangganan di sshinjector.net"
               echo "--------------------------------------"
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "User : $username Expire Pada Tanggal : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
               echo "echo "sshinjector.net- Username : $username sudah expired Pada Tanggal: $tgl $bulantahun dan telah di delete pada tanggal: $hariini "" >> /usr/local/bin/deleteduser
	           echo "Username $username yang expired pada $tgl $bulantahun telah berhasil dihapus dari sistem pada $hariini"
               userdel $username
               fi
               done
               echo " "
               echo "--------------------------------------"
               echo "Script telah berhasil dieksekusi"