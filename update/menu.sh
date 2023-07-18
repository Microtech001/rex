#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
## Foreground
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
#Domain & IPVPS
domain=$(cat /etc/xray/domain)
sldomain=$(cat /root/nsdomain)
IPVPS=$(curl -s ipinfo.io/ip)
# TOTAL ACC CREATE SSH/XRAYS
ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
vmess=$(grep -c -E "^### " "/etc/xray/config.json")
vless=$(grep -c -E "^#### " "/etc/xray/config.json")
tr=$(grep -c -E "^#&# " "/etc/xray/config.json")
trgo=$(grep -c -E "^### " "/etc/trojan-go/akun.conf")
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# RAM Info
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
# Total BANDWIDTH
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel5 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${WB}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
rm -fr /etc/xray/domain
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo $host > /etc/xray/domain
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew gen-ssl"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function genssl(){
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew gen-ssl... " 
sleep 2
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew gen-ssl done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl start nginx
systemctl start xray
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

echo ""
echo -e "${GREEN}......... ...........................,*///****/((/*,.........,,,*,,,,,,,,,,,,,,*${NC}"
echo -e "${GREEN}.....................................,,*/((((//((/*,..........,,,***,,,,,,,,,*/(${NC}"
echo -e "${GREEN}........ ............................,*(////**(///*,,.......,,,,,,,,,,,,,,,,*(##${NC}"
echo -e "${GREEN}..................................((((((//**////(((//,.....,,,,,,,,,,,,,****###/${NC}"
echo -e "${GREEN}............................../((//////////,***/*///(((/.,,,,,,,,,,,,*****#%%#/*${NC}"
echo -e "${GREEN}...........................(//**((((((((//*((,/(*,,,,,**/(/,,,,,,,*****/%&&&(/*,${NC}"
echo -e "${GREEN}........................,(/((((,*(//,,,,,.,,...,,*/(((*,,////,,*****//(&&&%(/**,${NC}"
echo -e "${GREEN}....................../((((*///.... .   ...... ..,.,,,,*///*///****//(&&@&#/****${NC}"
echo -e "${GREEN}..................../(((,*.                         ,..,,,**/**//*//%@@@%(/*****${NC}"
echo -e "${GREEN}.....,..,..........(/**.                               ....,,***///@@@&((/***///${NC}"
echo -e "${GREEN}......,,,.........**,.                                     .,./*///&&((/*///////${NC}"
echo -e "${GREEN}......,,,,......(*,..                                         ..*/(#/(/****/////${NC}"
echo -e "${GREEN}....,,,,.......(*,..                                            ..//(***////////${NC}"
echo -e "${GREEN}...,,,,,,,....(*,.                 (,         ,/ .       .,       ,,(/*/////////${NC}"
echo -e "${GREEN}.,,,,,,,,,,..#*..         *(     (.,.        .. ,,       ,,        .**//////////${NC}"
echo -e "${GREEN}.,,,,,,,,,,,(*..           &% .,.    ,.     .      .,  *.&         ..*******////${NC}"
echo -e "${GREEN}..,,,,,,,,,/(...            &%**,..    /   ..    . .,*.,.           .,//*****///${NC}"
echo -e "${GREEN}..,.,.,,,,.*,..          *(.,/,%.*   /,.    ..    .,.,*@%.           ./*********${NC}"
echo -e "${GREEN}.....,,,,,(,..          (.      *%.   **   ...    .%.    ,#,         .*/******,,${NC}"
echo -e "${GREEN}....,,,,,,,...                    %, (/*   *,,*  *                    ./******,,${NC}"
echo -e "${GREEN},,,,,,,,,#,...                        .,    ..*                       .,/*******${NC}"
echo -e "${GREEN},,,,,,,,,,,...            /.                 .       .   (            ..*****///${NC}"
echo -e "${GREEN},,,,,,,,(,...             (,/..      .#.,. ..%         *.              .,/,***//${NC}"
echo -e "${GREEN},,,,,,,(....                &,#.                     , %.              ..,/,**//${NC}"
echo -e "${GREEN},,,,,,(,...                  # //,&,*#.       *,*%. .,                 ..,,/*//(${NC}"
echo -e "${GREEN},,,,,/,...                     // *..#/ ,*@,  . ./&.@                   ..,,///(${NC}"
echo -e "${GREEN}((((((/.                         ., ..&,*.,.//&...%                      .,*,*((${NC}"
echo -e "${GREEN}//////(......                        %.  .   ..                           .,,,,(${NC}"
echo -e "${GREEN}**/(//*/........ .. ....                 *                                .,.../${NC}"
echo -e "${GREEN}/****/*,,./..........  *..              .,                              ..,...,*${NC}"
echo -e "${GREEN}*,*,,,,,,,..%&.*,.*.    ,....                                            ...%@*,${NC}"
echo -e "${GREEN}**,*,,.,,,,&&&.         .%.....                                   ....   ..(&&&,${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                      ⇱ MENU UTAMA ⇲                          \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                   ⇱ MAKLUMAT SERVER ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "  ${RB}🔘${NC} ${WB}OS      :  "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-) ${NC}         
echo -e "  ${RB}🔘${NC} ${WB}KERNEL  :  $(uname -r) ${NC} "
echo -e "  ${RB}🔘${NC} ${WB}UPTIME  :  $uptime ${NC} "
echo -e "  ${RB}🔘${NC} ${WB}RAM     :  $uram MB / $tram MB ${NC} "
echo -e "  ${RB}🔘${NC} ${WB}DOMAIN  :  $domain ${NC} "
echo -e "  ${RB}🔘${NC} ${WB}DNSTT   :  $sldomain ${NC} "
echo -e "  ${RB}🔘${NC} ${WB}IPVPS   :  $IPVPS ${NC} "
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                    ⇱ STATUS SERVICE ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
echo -e "     ${CYAN} SSH ${NC}: $ressh"" ${CYAN} NGINX ${NC}: $resngx"" ${CYAN}  XRAY ${NC}: $resv2r"" ${CYAN} TROJAN ${NC}: $resv2r"
echo -e "     ${CYAN}          DROPBEAR ${NC}: $resdbr" "${CYAN} SSH-WS ${NC}: $ressshws"
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                   ⇱ TOTAL BANDWIDTH ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "  ${RB}🔘${NC} ${WB}Daily Usage         : $ttoday ${NC}"
echo -e "  ${RB}🔘${NC} ${WB}Yesterday Usage     : $tyest ${NC}"
echo -e "  ${RB}🔘${NC} ${WB}Monthly Usage       : $tmon ${NC}"
echo -e "${NC} ${WB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}   "
echo -e "[$wh 1$y ] SSH WEBSOCKET MENU$wh   [$wh 10$y ] FIX SSLH+WS-TLS Error$wh"
echo -e "[$wh 2$y ] XRAY VLESS MENU$wh      [$wh 11$y ] SETTINGS$wh"
echo -e "[$wh 3$y ] XRAY VMESS MENU$wh      [$wh 12$y ] CHECK CPU & RAM$wh"
echo -e "[$wh 4$y ] WIREGUARD MENU$wh       [$wh 13$y ] CHECK BANDWIDTH$wh"
echo -e "[$wh 5$y ] INFO ALL PORT$wh        [$wh 14$y ] DNS CHANGER$wh"
echo -e "[$wh 6$y ] XRAY VERSION$wh         [$wh 15$y ] NETFLIX CHECKER$wh"
echo -e "[$wh 7$y ] CHECK IP PORT$wh        [$wh 16$y ] DELETE EXPIRED USERS$wh"
echo -e "[$wh 8$y ] CHECK SERVICE VPN$wh    [$wh 17$y ] EXIT$wh"
echo -e "[$wh 9$y ] UPDATE MENU$wh"
echo -e "${NC} ${WB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}   "
echo -e "  ${RB}🔘${NC} ${WB}Username      :  Microtech.Store "
echo -e "  ${RB}🔘${NC} ${WB}Licence Key   :  1527-3497-5092-3897 "
echo -e "  ${RB}🔘${NC} ${WB}Expired Date  :  Lifetime "
echo -e "  ${RB}🔘${NC} ${WB}Autoscript By :  Microtech.Store "
echo -e "  ${RB}🔘${NC} ${WB}Version       :  LimitedV23 "
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${WB}"
read -p "Select From Options [ 1 - 17 ] : " menu
case $menu in
1)
clear
sshovpnmenu
;;
2)
clear
vlessmenu
;;
3)
clear
vmessmenu
;;
4)
clear
wgmenu
;;
5)
clear
info
;;
6)
clear
xray version
;;
7)
clear
ipsaya
;;
8)
clear
running
;;
9)
clear
updatemenu
;;
10)
clear
sl-fix
;;
11)
clear
setmenu
;;
12)
clear
htop
;;
13)
clear
vnstat
;;
14)
clear
dns
;;
15)
clear
netf
;;
16)
clear
delexp && xp && restart
;;
17)
clear
exit
;;
*)
clear
menu
;;
esac
