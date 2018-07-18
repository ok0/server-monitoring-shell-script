#!/bin/bash

#author jonghun Yoon(https://github.com/ok0/server-monitoring-shell-script)

_SERVERNAME="API"
_DIVSTR="\n################################################"
_NOW=`date +%Y%m%d%H%M`
_OUTPUTPATH="___YOUR_PATH___.log"
_URI="___YOUR_PATH___"


# info..
echo -e "$_DIVSTR" | tee -a $_OUTPUTPATH
echo -e "NOW : $_NOW" | tee -a $_OUTPUTPATH


# meminfo, free -h, df -h
echo -e "$_DIVSTR" | tee -a $_OUTPUTPATH
echo -e "About memory.." | tee -a $_OUTPUTPATH
MEMINFO=`cat /proc/meminfo | grep 'MemTotal\|MemFree'`
FREE=`free -h`
DF=`df -h`

echo -e "\nmeminfo" | tee -a $_OUTPUTPATH
echo -e "$MEMINFO" | tee -a $_OUTPUTPATH
echo -e "\nfree -h" | tee -a $_OUTPUTPATH
echo -e "$FREE" | tee -a $_OUTPUTPATH
echo -e "\ndf -h" | tee -a $_OUTPUTPATH
echo -e "$DF" | tee -a $_OUTPUTPATH

# process list, process count, top, top10
echo -e "$_DIVSTR" | tee -a $_OUTPUTPATH
echo -e "About process.." | tee -a $_OUTPUTPATH

PS=`ps -ef | awk '{print $1, $8}' | uniq`
PSCOUNT=`ps -ef | wc -l`
TOP=`top -b | head -5`
TOP11=`top -b -n1 | head -17 | tail -11`

echo -e "\nps -ef" | tee -a $_OUTPUTPATH
echo -e "$PS" | tee -a $_OUTPUTPATH
echo -e "\nps -ef | wc -l" | tee -a $_OUTPUTPATH
echo -e "$PSCOUNT" | tee -a $_OUTPUTPATH
echo -e "\ntop -b | head -5" | tee -a $_OUTPUTPATH
echo -e "$TOP" | tee -a $_OUTPUTPATH
echo -e "top -b -n1 | head -17 | tail -11" | tee -a $_OUTPUTPATH
echo -e "\n$TOP11" | tee -a $_OUTPUTPATH


# httpd
echo -e "$_DIVSTR" | tee -a $_OUTPUTPATH
echo -e "About httpd..." | tee -a $_OUTPUTPATH
HTTPDCOUNT=`ps aux | grep 'httpd' | wc -l`
echo -e "\nps aux | grep 'httpd' | wc -l" | tee -a $_OUTPUTPATH
echo -e "$HTTPDCOUNT" | tee -a $_OUTPUTPATH


#POST DATA
_DATA=`cat $_OUTPUTPATH`
curl -d "server_name=$_SERVERNAME&data=$_DATA" $_URI
