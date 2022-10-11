#!/bin/bash

# Urls Enumeration Script start.
printf %39s |tr " " "=" | ~/go/bin/notify
echo "Urls Enumeration Starts....." | ~/go/bin/notify

echo `date +"%I:%M %p | %d-%m-%Y, %A"` | ~/go/bin/notify
printf %39s |tr " " "=" | ~/go/bin/notify


# Ulrs Enumeration
mkdir urls-$1
cd urls-$1

cat ../subdomains-$1/live-subdomains-$1.txt | ~/go/bin/waybackurls | ~/go/bin/anew urls-$1.txt
echo "waybackurls: done" | ~/go/bin/notify

cat ../subdomains-$1/live-subdomains-$1.txt | ~/go/bin/gau | ~/go/bin/anew urls-$1.txt
echo "gau: done" | ~/go/bin/notify

cd ..

# Javascript files
bash ~/tools/JSScanner/script.sh subdomains-$1/live-subdomains-$1.txt
echo "JSScanner: done" | ~/go/bin/notify


# Web technologies
whatweb -i subdomains-$1/live-subdomains-$1.txt --log-brief=whatweb-$1.txt
echo "whatweb: done" | ~/go/bin/notify

# Web screenshots
mkdir web-screenshots-$1
cd web-screenshots-$1
cat ../subdomains-$1/live-subdomains-$1.txt | aquatone -chrome-path /snap/bin/chromium

cd ../

#  UrlsEnumeration Script Ends
printf %39s |tr " " "=" | ~/go/bin/notify
echo "Urls Enumeration End....." | ~/go/bin/notify

echo `date +"%I:%M %p | %d-%m-%Y, %A"` | ~/go/bin/notify
printf %39s |tr " " "=" | ~/go/bin/notify

bash ~/scripts/recon-scritps/port-scanner.sh $1
echo "done task23" | ~/go/bin/notify

# Script ends here.

