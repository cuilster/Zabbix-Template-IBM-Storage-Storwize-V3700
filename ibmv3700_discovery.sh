#!/bin/bash

SSHCMD=`which ssh`
REPODIR=/usr/lib/zabbix/externalscripts
STORWIZEADDR=${1}
SSHKEY=/home/zabbix/.ssh/id_rsa

IFS='
'
system(){
	${SSHCMD} zabbix@${STORWIZEADDR} -i ${SSHKEY} "svcinfo lssystem; svcinfo lssystemstats; svcinfo lsenclosure" > ${REPODIR}/${STORWIZEADDR}.system.repo.tmp && mv ${REPODIR}/${STORWIZEADDR}.system.repo.tmp ${REPODIR}/${STORWIZEADDR}.system.repo

	echo "{
	   \"data\":[

		{
		       \"{#STORWIZEADDR}\":\"${STORWIZEADDR}\"}]}"
}

drive(){
        ${SSHCMD} zabbix@${STORWIZEADDR} -i ${SSHKEY} "svcinfo lsdrive" > ${REPODIR}/${STORWIZEADDR}.drive.repo.tmp && mv ${REPODIR}/${STORWIZEADDR}.drive.repo.tmp ${REPODIR}/${STORWIZEADDR}.drive.repo
		
	#START CHAR SLOT ID
        	SCS=$(cat  ${REPODIR}/${STORWIZEADDR}.drive.repo | grep -aob 'lot_id' | \grep -oE '^[0-9]+')
    	#END CHAR SLOT ID
        	ECS=$(($SCS + 7))
	
	echo "{
	        \"data\":[
	                " > ${REPODIR}/${STORWIZEADDR}.drive.tmp
	        for DRIVE in $(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | egrep -v ^id);
		do
       	        ID=$(echo ${DRIVE} | cut -c${SCS}-${ECS} | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')
	       	        echo " {\"{#SLOTID}\":"\"${ID}"\",\"{#STORWIZEADDR}\":"\"${STORWIZEADDR}"\"}," >> ${REPODIR}/${STORWIZEADDR}.drive.tmp
	        done
		cat ${REPODIR}/${STORWIZEADDR}.drive.tmp | sed '$s/},/}]}/g' && rm -f ${REPODIR}/${STORWIZEADDR}.drive.tmp
}

volume(){
	${SSHCMD} zabbix@${STORWIZEADDR} -i ${SSHKEY} "svcinfo lsvdisk" > ${REPODIR}/${STORWIZEADDR}.volume.repo.tmp && mv ${REPODIR}/${STORWIZEADDR}.volume.repo.tmp ${REPODIR}/${STORWIZEADDR}.volume.repo
        echo "{
                \"data\":[
                        " > ${REPODIR}/${STORWIZEADDR}.volume.tmp
                for VOLUME in $(cat ${REPODIR}/${STORWIZEADDR}.volume.repo | egrep -v ^id);
                do
                VOLNAME=$(echo ${VOLUME} | awk '{ print $2}')
                        STATUS=$(echo ${VOLUME} | awk '{ print $5}')
                        echo " {\"{#VOLNAME}\":"\"${VOLNAME}"\",\"{#STORWIZEADDR}\":"\"${STORWIZEADDR}"\"}," >> ${REPODIR}/${STORWIZEADDR}.volume.tmp
                done
                cat ${REPODIR}/${STORWIZEADDR}.volume.tmp | sed '$s/},/}]}/g' && rm -f ${REPODIR}/${STORWIZEADDR}.volume.tmp
}

if [[ "$2" == "drive" || "$2" == "system" || "$2" == "volume" ]]; then
	$2
fi
