#Brown.LiuZan@copyright
#Version: 1.0
#Date:2019-28-27
#Description: Provide filesystem facility.


#Imports.
source color.sh


#Global parameters.
#LZDEBUG=false
LZDEBUG=true
#LZTEST=false
LZTEST=true


#Module definitions.
function GetFileList() {
    local vDir=$1
    if [[ ! -d ${vDir} ]]; then
        print_bold_red "Director not found: ${vDir}"
        echo ""
    fi

    local vPathNames
    read -ra vPathNames <<< `ls ${vDir}`

    local vFileNames=()
    for i in ${vPathNames[@]}; do
        if [[ -f $i ]]; then
            vFileNames+=($i)
        fi
    done
    echo "${vFileNames[@]}"
}

function GetSubdirectoryList() {
    local vDir=$1
    if [[ ! -d ${vDir} ]]; then
        print_bold_red "Director not found: ${vDir}"
        echo ""
    fi

    local vPathNames
    read -ra vPathNames <<< `ls ${vDir}`

    local vFileNames=()
    for i in ${vPathNames[@]}; do
        if [[ -d $i ]]; then
            vFileNames+=($i)
        fi
    done
    echo "${vFileNames[@]}"
}

#Testing section of this module.
if $LZTEST; then
    gCwd=`pwd`
    vFileNames=`GetFileList ${gCwd}`
    echo "File number: ${#vFileNames[@]}"
    for i in ${vFileNames[@]}; do
        echo "File: $i"
    done
    vDirNames=`GetSubdirectoryList ${gCwd}`
    for i in ${vDirNames[@]}; do
        echo "Directory: $i"
    done
fi
