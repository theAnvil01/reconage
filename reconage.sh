#!/bin/bash
echo "reconage" | figlet 
echo "                  Created by TheCyberW0rld"

read " Enter Subdomain , you want to enumerate:" dom

mkdir $dom && cd $dom 
echo "Enumerating subdomains"
echo ""
echo ""
echo "starting amass"
amass enum  -d $dom -o amass.$dom.txt >> /dev/null
echo "amass has finished its task"
echo ""
echo ""
echo "Starting Sublist3r"
  sublist3r -d $dom -o sublist3r.$dom.txt >>/dev/null
echo "Sublist3r finished its task" 
echo "searching from crt.sh"
  curl -s https://crt.sh/\?q\=%25.$dom\&output\=json | jq -r ' .[].name_value' | sed 's/\*\.//g' | tee $dom.txt >>/dev/null
echo "crt.sh finished its task"
echo ""
echo "starting sub finder " 
subfinder -d $dom -v -o subfinder.$dom.txt 
echo "sub finder finished its task"
echo ""
echo ""
echo "find-domain is starting"
  findomain-linux -t $dom | tee finddomain.$dom.txt
echo "Find domain finished its task"

echo ""
echo "sorting subdomains"
echo *.txt | sort -u | subdomain.txt
echo "resolving subdomains"
  cat subdomain.txt | httpx | tee resolve.subdomains.txt >> /dev/null
echo "httpx fininshed its task"
echo ""
echo "fetching all urls with gau"
    resolve.subdomains.txt | gau | tee urls.txt >> /dev/null
echo " all url fetched with gau"


echo ""
echo "sorting urls"
    cat *.txt | egrep -v  "\.woff|\.ttf|\.svg|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico" | sed 's/:80//g;s/:443//g' | sort -u > final.urls.txt
echo "sorting url done"
