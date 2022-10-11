#!bin/bash

printf %39s |tr " " "=" | notify
echo "nuclei Starts....." | notify

mkdir nuclei

nuclei -l $1 -t /root/nuclei-templates/exposures/tokens/ -silent -c 50 | tee nuclei/nuclei-tks.txt

nuclei -l $1 -t /root/nuclei-templates/subdomain-takeover/ -silent -c 50 | tee nuclei/subdomain-takeover.txt

nuclei -l $1 -t /root/nuclei-templates/files/ -silent -c 50 | tee nuclei/nuclei-files.txt

nuclei -l $1 -t /root/nuclei-templates/cves/ -silent -c 50 | tee nuclei/nuclei-cves.txt

nuclei -l $1 -t /root/nuclei-templates/vulnerabilities/ -silent -c 50 | tee nuclei/nuclei-vulnerabilities.txt

nuclei -l $1 -t /root/nuclei-templates/generic-detections/ -silent -c 50 | tee nuclei/nuclei-generic-detections.txt

nuclei -l $1 -t /root/nuclei-templates/misconfiguration -silent -c 50 | tee nuclei/nuclei-mis.txt

nuclei -l $1 -t /root/nuclei-templates/* -silent -c 50 | tee nuclei/nuclei-all.txt

printf %39s |tr " " "=" | notify
echo "nuclei Ends....." | notify

echo `date +"%I:%M %p | %d-%m-%Y, %A"` | notify
printf %39s |tr " " "=" | notify

