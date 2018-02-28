#!/bin/bash

. /usr/lib/zabbix/externalscripts/ibm_3700_discovery.sh

STORWIZEADDR=$(echo $1)
SLOTID=$(echo $2)

#START CHAR SLOT ID
SCS=$(cat  ${REPODIR}/${STORWIZEADDR}.drive.repo | grep -aob 'lot_id' | \grep -oE '^[0-9]+')
#END CHAR SLOT ID
ECS=$(($SCS + 7))


IFS=' '

status () {
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c4-10,${SCS}-${ECS} --output-delimiter=" " | grep -w ${SLOTID})
        STATUS=$(echo ${LINE}| awk '{ print $1 }')
        echo ${STATUS}
}

use () {
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c33-39,${SCS}-${ECS} --output-delimiter=" " | grep -w ${SLOTID})
        USE=$(echo ${LINE}| awk '{ print $1 }')
        echo ${USE}
}

type () {
        DSCHR=$(cat  ${REPODIR}/${STORWIZEADDR}.drive.repo | grep -aob 'ech_type' | \grep -oE '^[0-9]+')
        DECHR=$(($DSCHR + 10))
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c${DSCHR}-${DECHR},${SCS}-${ECS} --output-delimiter=" " | grep -w ${SLOTID})
        TYPE=$(echo ${LINE}| awk '{ print $1 }')
        echo ${TYPE}
}

mdisk_name  () {
        DSCHR=$(cat  ${REPODIR}/${STORWIZEADDR}.drive.repo | grep -aob 'disk_name' | \grep -oE '^[0-9]+')
        DECHR=$(($DSCHR + 10))
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c${DSCHR}-${DECHR},${SCS}-${ECS} --output-delimiter=" " | grep -w ${SLOTID})
        if [ $(echo ${LINE} | grep -o " " | wc -l) -gt 0  ] ; then
                MDISK_NAME=$(echo ${LINE}| awk '{ print $1 }')
        fi
        echo ${MDISK_NAME}
}

enclosure_id () {
        DSCHR=$(cat  ${REPODIR}/${STORWIZEADDR}.drive.repo | grep -aob 'nclosure_id' | \grep -oE '^[0-9]+')
        DECHR=$(($DSCHR + 4))
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c${DSCHR}-${DECHR},${SCS}-${ECS} --output-delimiter=" " | awk -v SLOTID=${SLOTID} '{if ($2==SLOTID){print $0}}')
        ENCLOUSURE_ID=$(echo ${LINE}| awk '{ print $1 }')
        echo ${ENCLOUSURE_ID}
}

$3

