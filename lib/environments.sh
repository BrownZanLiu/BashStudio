#! /usr/bin/bash

################################################################################
# Author:
#	brown.liuzan
# Copyright owner:
#	brown.liuzan
# Email:
#	brown.liuzan@outlook.com
# Description:
#	Definitions of environment variables.
################################################################################

if [[ ${LIUZAN_ENVIRONMENTS_SH} != "LIUZAN_ENVIRONMENTS_SH_DEFINED" ]]; then
readonly LIUZAN_ENVIRONMENTS_SH="LIUZAN_ENVIRONMENTS_SH_DEFINED"

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
OS_ID=$(get_os_id)
ZBIN_ROOT=/usr/local/zbin
ZLIB_ROOT=/usr/local/zlib
ZETC_ROOT=/usr/local/zetc
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

####Unit test section####
if false; then
	echo "OS_ID: ${OS_ID}"
	echo "ZBIN_ROOT: ${ZBIN_ROOT}"
	echo "ZLIB_ROOT: ${ZLIB_ROOT}"
	echo "ZETC_ROOT: ${ZETC_ROOT}"
	echo "PATH: ${PATH}"
fi

fi  # LIUZAN_ENVIRONMENTS_SH
