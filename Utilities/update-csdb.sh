#! /usr/bin/bash
#Brown@copyright
#Version: 1.0 
#Date: 20180614
#Description: Used to create/update the cscope database of a special kind of source files under specified diretory.


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
    echo -e "\tRootDir\tthe root directory of target project" 1>&2
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
    if [[ -f ${TagBuildDir}/${SrcFiles} ]]; then
        mv ${TagBuildDir}/${SrcFiles} ${TagBuildDir}/${SrcFiles}.bak
    fi
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
        if [[ -f ${TagBuildDir}/${SrcFiles}.bak ]]; then
            rm -f ${TagBuildDir}/${SrcFiles}.bak
        fi
        ls -lh ${TagBuildDir}/${SrcFiles}
    else
        echo -e "Failed to create/update a source file list for cscope.\n" 1>&2
        exit 1
    fi
    echo -e "===>Done\n"
fi

#Generate cscope database file.
echo "===>Try to generate/update cscope database file."
CsDbFile=$(basename ${RootDir}).cscope.out
if [[ -f cscope.out ]]; then
    rm -f cscope.out
fi
if [[ -f ${TagBuildDir}/${CsDbFile} ]]; then
    mv ${TagBuildDir}/${CsDbFile} ${TagBuildDir}/${CsDbFile}.bak
fi
cscope -bqk -i ${TagBuildDir}/${SrcFiles}
if [[ -f cscope.out ]]; then
    mv cscope.out ${TagBuildDir}/${CsDbFile}
    if [[ -f ${TagBuildDir}/${CsDbFile} ]]; then
        rm -f ${TagBuildDir}/${CsDbFile}.bak
        ls -lh ${TagBuildDir}/${CsDbFile}
    fi
    if [[ -f ${TagBuildDir}/${CsDbFile}.bak ]]; then
        mv ${TagBuildDir}/${CsDbFile}.bak ${TagBuildDir}/${CsDbFile}
        echo -e "Failed to generate/udpate cscope database file.\n"
        exit 1
    fi
else
    if [[ -f ${TagBuildDir}/${CsDbFile}.bak ]]; then
        mv ${TagBuildDir}/${CsDbFile}.bak ${TagBuildDir}/${CsDbFile}
    fi
    echo -e "Failed to generate/update cscope database file.\n"
    exit 1
fi
echo -e "===>Done.\n"
