echo "Port Apa Yang Ingin Anda ubah?"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "1) Edit Port Dropbear"  | tee -a log-install.txt
echo "2) Edit Port OpenSSH"  | tee -a log-install.txt
echo "3) Edit Port Squid"  | tee -a log-install.txt
echo "4) Edit Port OpenVPN"  | tee -a log-install.txt
echo ""
echo -e "\e[031;1m x\e[0m) Exit"
read -p "Silahkan pilih service, Dan tekan tombol ENTER: " option
case $option in
1)
clear
edit-port-dropbear.sh
;;
2)
clear
edit-port-openssh.sh
;;
3)
clear
edit-port-squid.sh
;;
4)
clear
edit-port-openvpn.sh
;;
x)
;;
esac
   