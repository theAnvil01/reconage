#!/bin/bash

mkdir subdomains-$1
cd subdomains-$1

echo "target: $1" | ~/go/bin/notify
echo "Recon: recon-subdomains-finder.sh started" | ~/go/bin/notify

# Subdomains finder
echo "finding subdomains..." | ~/go/bin/notify

amass enum -brute -df ../wildcard-$1.txt | ~/go/bin/anew subdomains-$1.txt
echo "amass: done" | ~/go/bin/notify

subfinder -dL ../wildcard-$1.txt | ~/go/bin/anew subdomains-$1.txt
echo "subfinder: done" | ~/go/bin/notify

cat ../wildcard-$1.txt | assetfinder -subs-only | ~/go/bin/anew subdomains-$1.txt
echo "assetfinder: done" | ~/go/bin/notify

cat wildcard-$1.txt | while read domain
do
curl -s https://crt.sh/\?q\=%25.$domain\&output\=json | jq -r ' .[].name_value' | sed 's/\*\.//g' | ~/go/bin/anew subdomains-$1.txt
done
echo "crt: done" | ~/go/bin/notify

cat subdomains-$1.txt | wc -l | ~/go/bin/notify
echo "finished finding subdomains..." | ~/go/bin/notify

echo "----------------------------------------" | ~/go/bin/notify

# Dev subdomains finder
echo "finding dev subdomains..." | ~/go/bin/notify

dnsgen subdomains-$1.txt | tee dnsgen-subdomains-$1.txt
cat dnsgen-subdomains-$1.txt | sort -u | tee dev-subdomains-$1.txt
echo "finished finding dev subdomains..." | ~/go/bin/notify

# Live subdomains finder
echo "live-recon started: $1" | ~/go/bin/notify

cat dev-subdomains-$1.txt | ~/go/bin/httprobe -c 80 | ~/go/bin/anew live-subdomains-$1.txt
echo "httprobe: done" | ~/go/bin/notify

cat dev-subdomains-$1.txt | ~/go/bin/httpx | ~/go/bin/anew live-subdomains-$1.txt
echo "httpx: done" | ~/go/bin/notify

echo "total live subdomains: " | ~/go/bin/notify
cat live-subdomains-$1.txt | wc -l | ~/go/bin/notify


echo "Recon: recon-subdomains-finder.sh finished" | ~/go/bin/notify
echo "----------------------------------------" | ~/go/bin/notify

cd ../

bash ~/scripts/recon-scritps/recon-urls-enumeration.sh $1

echo "done task 1" | ~/go/bin/notify
