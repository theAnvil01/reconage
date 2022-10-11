echo "Finding ips " | ~/go/bin/notify

mkdir port-scanner
cd port-scanner

# Finding ip-address
cat ../subdomains-$1/live-subdomains-$1.txt | dnsx -resp-only -a -silent | anew ips-subdomains-$1.txt

# Finding Ips:Ports
echo "Finding ips:ports " | ~/go/bin/notify
cat ../subdomains-$1/live-subdomains-$1.txt | dnsx -resp-only -a -silent | naabu -top-ports 1000 -silent | anew ips-open-ports-subdomains-$1.txt

# Finding open-ports
echo "Finding host:ports " | ~/go/bin/notify
cat ../subdomains-$1/subdomains-$1.txt | naabu -top-ports 1000 -silent | anew open-ports-subdomains-$1.txt

# live Finding open-ports
echo "Finding live host:ports " | ~/go/bin/notify
cat  open-ports-subdomains-$1.txt | httpx -silent | anew live-open-ports-subdomains-$1.txt

cd ..

bash ~/scripts/recon-scritps/nuclei-script.sh ../urls-$1/urls-$1.txt
bash ~/scripts/recon-scritps/nuclei-script.sh ../subdomains-$1/live-subdomains.txt

echo "done task 3" | ~/go/bin/notify
