<p align="center">


<h2 align="center">
Auto Script Install All VPN Service
By MICROTECH.STORE (MTS) 
<img src="https://img.shields.io/badge/PreRelease-v4.0-purple.svg"></h2>

</p> 
<h2 align="center"> Supported Linux Distribution</h2>
<p align="center"><img src="https://d33wubrfki0l68.cloudfront.net/5911c43be3b1da526ed609e9c55783d9d0f6b066/9858b/assets/img/debian-ubuntu-hover.png"width="400"></p> 
<p align="center">
<img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%209&message=Stretch&color=purple"> 
<img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2010&message=Buster&color=purple">  
<img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2011&message=Bullseye&color=purple"> 
<p align="center">
<img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2018&message=Lts&color=red"> 
<img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2020&message=Lts&color=red">
</p>

<h2 align="center">Network VPN</h2>

<h2 align="center">

![Hits](https://img.shields.io/badge/SSH-SlowDNS-8020f3?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)
![Hits](https://img.shields.io/badge/SSH-Websocket-8020f3?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)
![Hits](https://img.shields.io/badge/XRAY-Vmess-f34b20?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)
![Hits](https://img.shields.io/badge/XRAY-VLess-f34b20?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)
![Hits](https://img.shields.io/badge/XRAY-Trojan-f34b20?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)
</h2>


## ADDITIONAL INFO, PLEASE READ
* MINIMUM RAM 1 GB TO USE THIS SCRIPT

# Special For OS
*  Debian 9 / 10 / 11 (Recommended Debian 10 for faster installing)
*  Ubuntu 18.04 / 20.04
* Tested For VPS AWS, AZURE, DigitalOcean, Centerhop

## Installation 
## 1.
<img src="https://img.shields.io/badge/Update%20_&_%20Upgrade Debian 9,10,11-purple">

 ```html
apt-get update && apt-get upgrade -y && update-grub && sleep 2 && reboot 
  ```
  or

```html
apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot

```
  
  <img src="https://img.shields.io/badge/Update%20_&_%20Upgrade Ubuntu 18 & 20 LTS-purple">

  ```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && sleep 2 && reboot

  ```

   or
   ```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && reboot

  ```
  
### 2.

  <img src="https://img.shields.io/badge/Install_All_Service_VPN%20-purple">

* Install All VPN Service / Install All VPN Service
   
```html
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/Microtech001/rex/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
```

### 3. Info Websocket
* Websocket must use a subdomain/domain and already pointed at cloudflare (CDN CLOUDFLARE)
* Without a subdomain/domain it's impossible to connect with bugs originating from cloudflare

# Special INFO SlowDNS
• SSH Over DNS (SlowDNS)
* the speed is limited
* download speed 4 Mbps (Max Speed)
* Support all ssh ports

### Script Features

• CHECK ALL IP AND PORT (Service ALL VPN)

• SSH & OpenVPN

• SSH Over DNS (SlowDNS)

• SSH Over Websocket (Cloudflare)

• OpenVPN Over Websocket (Cloudflare)


• SSH CloudFront Over Websocket (Aws CloudFront Only) [OFF]

• OHP SSH & OHP Dropbear & OHP OpenVPN (OPEN HTTP PUNCHER)

• XRAY VMESS 

• XRAY VLESS

• Backup Data ALL Service

• Restore Data ALL Service

• Auto Fix

• Auto Update

### Os Supported

• Debian 11, 10 & 9

• Ubuntu 18.04 & 20.04

# Service & Port

• SlowDNS                   : All Port SSH

• OpenSSH                   : 22, 2253

• Dropbear                  : 443, 109, 143, 1153

• Stunnel5                  : 442, 445, 777

• OpenVPN                   : TCP 1194, UDP 2200, SSL 990

• Websocket SSH TLS         : 443

• Websocket SSH HTTP        : 8880

• Websocket OpenVPN         : 2086

• Squid Proxy               : 3128, 8080

• Badvpn                    : 7100, 7200, 7300

• Nginx                     : 89

• XRAYS Vmess TLS           : 443

• XRAYS Vmess None TLS      : 80

• XRAYS Vless TLS           : 443

• XRAYS Vless None TLS      : 80

• XRAYS Trojan              : 2083

• OHP SSH                   : 8181

• OHP Dropbear              : 8282

• OHP OpenVPN               : 8383

• Trojan Go                 : 2087

• CloudFront Over Websocket : [OFF]


 ### Server Information & Other Features

• Timezone                : Asia/Kuala_Lumpur (GMT +8)

• Fail2Ban                : [ON]

• Dflate                  : [ON]

• IPtables                : [ON]

• Auto-Reboot             : [ON]

• IPv6                    : [OFF]

• Autoreboot On 05.00 GMT +8

• Auto Delete Expired Account

• Full Orders For Various Services

• White Label

• Auto Fix

• Auto Update

<p align="center">
<img height=21 src="https://komarev.com/ghpvc/?username=MicrotechStore">
</p>
<div height='45' align="center">

<h2 align="center">
