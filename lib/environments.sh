#! /usr/bin/bash

################################################################################
# Copyright: brown.liuzan@outlook.com
# Version: 1.0
# Date: 2023-24-29
# Description:
################################################################################



if [[ ${LIUZAN_ENVIRONMENTS_SH} != "LIUZAN_ENVIRONMENTS_SH_DEFINED" ]]; then
readonly LIUZAN_ENVIRONMENTS_SH="LIUZAN_ENVIRONMENTS_SH_DEFINED"



####Definition of global parameters####
if [[ -z "${ZBASH_LIB_ROOT}" ]]; then
	ZBASH_LIB_ROOT=/usr/local/zbash/bin/lib
fi
ZBASH_BIN_ROOT=$(dirname ${ZBASH_LIB_ROOT})
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH=${ZBASH_BIN_ROOT}:${PATH}


####Imports of other module files####
source ${ZBASH_LIB_ROOT}/errno.sh
source ${ZBASH_LIB_ROOT}/printer.sh


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
if false; then
	print_white "ZBASH_BIN_ROOT: ${ZBASH_BIN_ROOT}"
	print_white "ZBASH_LIB_ROOT: ${ZBASH_LIB_ROOT}"
	print_white "PATH: ${PATH}"
	print_white "get_os_id: $(get_os_id)"
	print_white "OS_ID: ${OS_ID}"
fi



fi  # LIUZAN_ENVIRONMENTS_SH
