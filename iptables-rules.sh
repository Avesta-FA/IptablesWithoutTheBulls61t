#!/bin/sh

#Author: Avesta Fahimipour  
#No guarantees, no warranties, and no rights reserved. 


#We will first clean the rules that exist
iptables -F

#Best practice for firewalls is default deny
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#These are related to the loopback address
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#By default we won't allow new inbound connections, only already established connections 
iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT


#Depending on the services on your server open the ports 
iptables -A INPUT -p tcp --dport <PortNumber> -j ACCEPT


#All new and already established outbound connection is allowed
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT


#Enable logging
iptables -A INPUT -j LOG
iptables -A OUTPUT -j LOG
iptables -A FORWARD -j LOG
