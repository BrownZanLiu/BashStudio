#! /usr/bin/bash

################################################################################
# Copyright: brown.liuzan@outlook.com
# Version: 1.0
# Date: 2023-24-29
# Description:
################################################################################



if [[ ${LIUZAN_ENVIRONMENTS_SH} != "LIUZAN_ENVIRONMENTS_SH_DEFINED" ]]; then
readonly LIUZAN_ENVIRONMENTS_SH="LIUZAN_ENVIRONMENTS_SH_DEFINED"



####Imports of other module files####
source lib/errno.sh
source lib/printer.sh


####Definition of global parameters####
gUnitTestEnabled=false
BASH_BIN=/usr/local/bash/bin
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH=${BASH_BIN}:${PATH}

####Definition of functions####
function get_os_id() {
	local vOsName
	local vLine

	if [[ ! -f /etc/os-release ]]; then
		echo 'unknown'
		return ${ENOENT}
	fi

	local vOsId=""
	while read vLine; do
		if [[ ${vLine%%=*} == 'ID' ]]; then
			vOsId=${vLine##*=}
			vOsId=${vOsId#\"}
			vOsId=${vOsId%\"}
			break
		fi
	done < /etc/os-release
	echo "${vOsId}"
}


####Definition of global parameters####
readonly OS_ID=$(get_os_id)

####Unit test section####
if ${gUnitTestEnabled}; then
	print_white "get_os_id: $(get_os_id)"
	print_white "OS_ID: ${OS_ID}"
fi



fi  # LIUZAN_ENVIRONMENTS_SH
