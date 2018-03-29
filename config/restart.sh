echo "Apa Yang Ingin Anda Restart?"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "1) Restart Dropbear"  | tee -a log-install.txt
echo "2) Restart Squid"  | tee -a log-install.txt
echo "3) Restart OpenVPN"  | tee -a log-install.txt
echo "4) Restart Webmin"  | tee -a log-install.txt
echo ""
echo -e "\e[031;1m x\e[0m) Exit"
read -p "Silahkan pilih service, Dan tekan tombol ENTER: " option
case $option in
1)
clear
restart-dropbear.sh
;;
2)
clear
restart-squid.sh
;;
3)
clear
restart-openvpn.sh
;;
4)
clear
restart-webmin.sh
;;
x)
;;
esac
   