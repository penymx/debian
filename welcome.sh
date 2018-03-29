#!/bin/bash
#script copyright www.sshinjector.net

IP=`dig +short myip.opendns.com @resolver1.opendns.com`

    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
	LGREEN=`echo "\033[0m\033[1;32m"`
    ENTER_LINE=`echo "\033[33m"`
	LRED=`echo "\033[0m\033[1;31m"`
	BLUE=`echo "\033[0m\033[1;36m"`
echo
echo -e "${BLUE}----------- Hai Admin, Selamat datang di Server $IP -----------${NORMAL}"
echo -e "Jika butuh bantuan & Pertanyaan hubungi kami di https://facebook.com/Najahiii"
echo -e "${NUMBER}---------- Silahkan ketik ${LRED}menu${NUMBER} untuk masuk ke Fitur Menu VPS ----------${NORMAL}"
echo ""
