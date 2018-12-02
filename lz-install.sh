#! /usr/bin/bash
#Brown@copyright
#Version: v1.0
#Date: 20181202
#Description: Install modules and tools from ${SHROOT} into ${LZBIN}.


#Imports.
source color.sh


#Global parameters.
#LZDEBUG=false
LZDEBUG=true


#Main logic.
if [[ -z "${LZBIN}" ]]; then
    print_blinking_red "LZBIN undefined."
    exit 1
fi

for script in *.sh; do
    if [[ "${script}" != "`basename $0`" ]]; then
        cp ${script} ${LZBIN}
    fi
done

cd ${LZBIN}
echo "`pwd`:"
ls ${LZBIN}

