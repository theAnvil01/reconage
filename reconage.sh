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
echo *.txt | sort -u | subdomain.txt
