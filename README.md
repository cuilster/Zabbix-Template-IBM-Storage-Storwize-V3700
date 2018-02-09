# Zabbix-Template-IBM-Storage-Storwize-V3700
# Zabbix 3.4

# SSH Connection to Storwize device

1. enable loginshell for user zabbix
	
	- root login zabbix server
	- nano /etc/passwd
	* alter line:
		zabbix:x:109:114::/home/zabbix:/bin/false
	'to:
		zabbix:x:109:114::/home/zabbix:/bin/bash
 
2. create / move home dir of user zabbix
 source: https://www.zabbix.com/documentation/3.4/manual/config/items/itemtypes/ssh_checks

	- service zabbix-agent stop
	- service zabbix-server stop
	- usermod -m -d /home/zabbix zabbix
	- test -d /home/zabbix || mkdir /home/zabbix
	- chown zabbix:zabbix /home/zabbix
	- chmod 700 /home/zabbix
	- service zabbix-agent start
	- service zabbix-server start
	
3. create SSH Key Pair
	
	- su zabbix
	- ssh-keygen -t rsa
	- download "id_rsa_pub"
	
4. create user in StorWize

	- login to storwize
	- create new user "zabbix" with no password
	- upload public key
	- save

5. on zabbix server add storwize to known_hosts

	- login as use zabbix
	- add storwize to known hosts in /home/zabbix/.ssh/known_host manually
	- or run /usr/bin/ssh <IP Storwize>

# enable scripts
 
	- copy Scripts to your prefered Script folder, which zabbix knowns by /etc/zabbix/zabbix_server.conf entry
		line "ExternalScripts=/usr/lib/zabbix/externalscripts"
	- own scripts by user "zabbix"  
		chown zabbix:zabbix <script>
	- make script executable
		chmod +x <script>
	
# Template Import

	- import TPL_IBM_Storage_Storwize_V3700.xml
	- assign Template to existing IBM V3700
	- standard macro {HOST.IP} is used
	
--Info
	
	- Items are changed to external checks
	- Items are German now / change as desired
	- check interval is changed to 5-10 minutes

# TODO: 
	- disable loginshell for zabbix user
