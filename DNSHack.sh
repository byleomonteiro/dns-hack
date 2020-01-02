#!/bin/bash 

if [ "$1" == "" ] && [ "$2" == "" ]
then	
	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "                **---Leon4rdoMonteiro---**                  "
	echo "                         DNS HACKING                        "
	echo "          Exemplo de USO: $0 alvo.com.br wordlist.txt       "
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
else
	# NAME SERVERS 
	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "             ENCONTRANDO NAME SERVERS             "
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	host -t ns $1 | cut -d " " -f4 > nsrv.txt 
	cat nsrv.txt
	
	# MAIL SERVERS 
	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "          ENCONTRANDO MAIL SERVERS            "
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	host -t mx $1 | cut -d " " -f7  > msrv.txt
	cat msrv.txt

	# ZONE TRANSFER --FORCE 
	
	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "     TENTANDO FORÇAR TRANSFERÊNCIA DE ZONA    "
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""

	for server in $(cat nsrv.txt);
	do
		host -l $1 $server | grep "has address"
	done

	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo " 	      REALIZANDO BRUTE FORCE DOMAIN             "
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""

	for url in $(cat $2);
	do
		host $url.$1 | grep "has address"
	done

	echo "" 
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "              EXECUTADO COM SUCESSO!                 "
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	rm nsrv.txt
	rm msrv.txt
fi

