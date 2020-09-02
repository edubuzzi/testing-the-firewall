#!/bin/bash
BLUE='\033[1;34m'
BOLD='\033[1m'
COLORF='\033[0m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
RED='\033[1;31m'
credits(){
echo
echo -e "${BOLD}===============================================${COLORF}"
echo -e "${BOLD}Script developed by:${COLORF} ${BLUE}Eduardo Buzzi${COLORF}"
echo -e "${BOLD}More Scripts in:${COLORF} ${RED}https://github.com/eduardbuzzi${COLORF}"
echo -e "${BOLD}===============================================${COLORF}"
}
ip_or_domain(){
echo
read -p "IP/DOMAIN => " IPDOMAIN
if [ -z "$IPDOMAIN" ]
then
ip_or_domain
fi
VERIFICATION=$(nmap -sn $IPDOMAIN | grep "1 host up")
if [ -z "$VERIFICATION" ]
then
ip_or_domain
fi
}
testing(){
IP=$(nmap -sn $IPDOMAIN | grep "report" | cut -d '(' -f2 | tr -d ')')
echo
echo "Checking if there is any Firewall blocking any connection in $IPDOMAIN"
echo
UDP=$(traceroute $IPDOMAIN -n -U | egrep "$IP" | grep -v "traceroute")
TCP=$(traceroute $IPDOMAIN -n -T | egrep "$IP" | grep -v "traceroute")
ICMP=$(traceroute $IPDOMAIN -n -I | egrep "$IP" | grep -v "traceroute")
if [ -z "$UDP" ]
then
echo -e "${RED}FIREWALL BLOCKING UDP CONNECTIONS"
else
echo -e "${GREEN}NO FIREWALL BLOCKING UDP CONNECTIONS"
fi
if [ -z "$TCP" ]
then
echo -e "${RED}FIREWALL BLOCKING TCP CONNECTIONS"
else
echo -e "${GREEN}NO FIREWALL BLOCKING TCP CONNECTIONS"
fi
if [ -z "$ICMP" ]
then
echo -e "${RED}FIREWALL BLOCKING ICMP CONNECTIONS${COLORF}"
else
echo -e "${GREEN}NO FIREWALL BLOCKING ICMP CONNECTIONS${COLORF}"
fi
}
principal(){
ip_or_domain
testing
principal
}
credits
principal
