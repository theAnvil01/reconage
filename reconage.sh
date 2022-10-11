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
echo amass.$dom.txt | sort -u | subdomain.txt
