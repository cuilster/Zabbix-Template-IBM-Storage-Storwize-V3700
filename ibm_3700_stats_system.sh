#!/bin/bash

. /usr/lib/zabbix/externalscripts/ibm_3700_discovery.sh

STORWIZEADDR=$(echo $1)

space_allocated_to_vdisks () {
	grep -w "space_allocated_to_vdisks" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

total_mdisk_capacity () {
        grep -w "total_mdisk_capacity" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

total_free_space () {
        grep -w "total_free_space" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}	

cpu_pc () {
        grep -w "cpu_pc" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

fc_mb () {
        grep -w "fc_mb" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

fc_io () {
        grep -w "fc_io" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

sas_mb () {
        grep -w "sas_mb" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

sas_io () {
        grep -w "sas_io" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

iscsi_mb () {
        grep -w "iscsi_mb" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

iscsi_io () {
grep -w "iscsi_io" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

write_cache_pc () {
        grep -w "write_cache_pc" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

total_cache_pc () {
        grep -w "total_cache_pc" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

power_w () {
        grep -w "power_w" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

temp_c () {
        grep -w "temp_c" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

vdisk_ms () {
        grep -w "vdisk_ms" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

mdisk_ms () {
	grep -w "mdisk_ms" ${REPODIR}/${STORWIZEADDR}.system.repo | awk '{ print $2 }'
}

psu_online () {
	grep -w "online_PSUs" -A1 ${REPODIR}/${STORWIZEADDR}.system.repo | cut -c123-133 | tail -n1
}

$2

