#!/bin/bash

. /usr/lib/zabbix/externalscripts/ibm_3700_discovery.sh

STORWIZEADDR=$(echo $1)
VOLNAME=$(echo $2)

IFS=' '

status () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.volume.repo | awk '{ print $2, $5}' | grep -w ${VOLNAME})
	STATUS=$(echo ${LINE}| awk '{ print $2 }')
	echo ${STATUS}
}

size () {
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.volume.repo | awk '{ print $2, $8}' | grep -w ${VOLNAME})
        SIZE=$(echo ${LINE}| awk '{ print $2 }')
	echo ${SIZE}
}

$3
