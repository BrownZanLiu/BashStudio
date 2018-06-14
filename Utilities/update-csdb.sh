#! /usr/bin/bash
#Brown@copyright
#Version: 1.0 
#Date: 20180614
#Description: Used to create/update and install specified project cscope database.


#Defining section of this utility.
#DODEBUG=false
DODEBUG=true

#Make sure the tag-building directory to exist.
TagBuildDir=/home/CscopeAndCtags
if [[ ! -d ${TagBuildDir} ]]; then
    mkdir ${TagBuildDir}
fi
if [[ ! -d ${TagBuildDir} ]]; then
    echo "${TagBuldDir} doesn't exist and failed to create it." 1>&2
    exit 1
fi

#Usage check and argument parse
usage ()
{
    echo -e "Usage:\n\tupdate-csdb.sh <c|b|p> RootDir" 1>&2
    echo -e "Note:\n\tc\tC and C++ source files\n\tb\tbash scripts\n\tp\tPython scripts" 1>&2
    exit 1
}
if [[ ${#@} -ne 2 ]]; then
    usage
else
    if [[ ! -d $2 ]]; then
        echo -e "$2: Not existed or not project directory." 1>&2
        usage
    fi

    RootDir=$2
    SrcFiles=$(basename ${RootDir}).csf
    case $1 in
    'c')
        echo -e "===>Try to create C/C++ source file list for updating cscope database of $2"
        $(find ${RootDir} -name '*.[h|hpp|c|C|cc|cp|cpp|cxx|c++]' -type f > ${TagBuildDir}/${SrcFiles});;
    'b')
        echo -e "===>Try to create C/C++ source file list for updating cscope database of $2"
        $(find ${RootDir} -name '*.sh' -type f > ${TagBuildDir}/${SrcFiles});;
    'p')
        echo -e "===>Try to create C/C++ source file list for updating cscope database of $2"
        $(find ${RootDir} -name '*.py' -type f > ${TagBuildDir}/${SrcFiles});;
    *)
        usage;;
    esac
    if [[ -f ${TagBuildDir}/${SrcFiles} ]]; then
        ls -lh ${TagBuildDir}/${SrcFiles}
    else
        echo -e "Failed to create a source file list for cscope.\n" 1>&2
        exit 1
    fi
    echo -e "===>Done\n"
fi

