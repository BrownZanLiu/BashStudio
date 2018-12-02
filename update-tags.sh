#! /usr/bin/bash
#Brown@copyright
#Version: 1.0 
#Date: 20180615
#Description: Used to create/update and install the cscope database of a special kind of source files under specified diretory.


#Imports.
source color.sh


#Global parameters.
#LZDEBUG=false
LZDEBUG=true


#Main logic.
if [[ -z "${LZHOME}" ]]; then
    print_blinking_red "LZHOME undefined."
    exit 1
fi

echo "===>Try to make sure tag directory to exist."
TagsDir=${LZHOME}/CscopeAndCtags
if [[ ! -d ${TagsDir} ]]; then
    mkdir ${TagsDir}
fi
if [[ ! -d ${TagsDir} ]]; then
    echo "${TagBuldDir} doesn't exist and failed to create it." 1>&2
    exit 1
fi
echo -e "===>Done\n"

#Usage check and argument handle 
echo "===>Try to check/parse arguments."
usage ()
{
    echo -e "Usage:\n\tupdate-tags.sh <c|b|p> RootDir" 1>&2
    echo -e "Note:\n\tc\tC and C++ source files\n\tb\tbash scripts\n\tp\tPython scripts\n\tm\tmake files" 1>&2
    echo -e "\tRootDir\tthe root directory to create/update cscope dababse" 1>&2
    exit 1
}
if [[ ${#@} -ne 2 ]]; then
    usage
else
    if [[ ! -d $2 ]]; then
        echo -e "$2: invalid source file  directory." 1>&2
        usage
    fi
    if [[ -n $(whereis readlink) ]]; then
        RootDir=$(readlink -f $2)
    elif [[ -n $(whereis readpath) ]]; then
        RootDir=$(readpath -f $2)
    else
        echo -e "Only support CentOS and Ubuntu family OSes.\n" 1>&2
        exit 1
    fi
    if ${LZDEBUG}; then
        echo "RootDir=${RootDir}"
    fi
    BaseName=$(basename ${RootDir}).$1
    case $1 in
    'c')
        CtagLangId=C,C++;;
    'b')
        CtagLangId=Sh;;
    'p')
        CtagLangId=Python;;
    'm')
        CtagLangId=Make;;
    *)
        usage;;
    esac
fi
echo -e "===>Done\n"

#Generate ctags files.
echo "===>Try to generate ctags files."
cd ${RootDir}
if ${LZDEBUG}; then
    echo "CtagLangId=${CtagLangId}"
    echo "PWD=`pwd`"
fi
if [[ -f tags ]]; then
    rm -f tags
fi
if [[ -f "${TagsDir}/${BaseName}.tags" ]]; then
    mv ${TagsDir}/${BaseName}.tags ${TagsDir}/${BaseName}.tags.bak
fi
ctags -R --languages=${CtagLangId}
if [[ ! -f tags ]]; then
    if [[ -f "${TagsDir}/${BaseName}.tags.bak" ]]; then
        mv ${TagsDir}/${BaseName}.tags.bak ${TagsDir}/${BaseName}.tags
    fi
    echo -e "Failed to generate ctags files.\n" 1>&2
    exit 1
else
    mv tags ${TagsDir}/${BaseName}.tags
    if [[ -f "${TagsDir}/${BaseName}.tags" ]]; then
        rm -f ${TagsDir}/${BaseName}.tags.bak
        ls -lh ${TagsDir}/${BaseName}.tags
    else
        if [[ -f "${TagsDir}/${BaseName}.tags.bak" ]]; then
            mv ${TagsDir}/${BaseName}.tags.bak ${TagsDir}/${BaseName}.tags
        fi
        echo -e "Failed to mv ctags files to ${TagsDir}.\n" 1>&2
        exit 1
    fi
fi
cd -
echo -e "===>Done\n"

#Register ctags file.
echo "===>Try to register ctags file."
if ${LZDEBUG}; then
    echo "tags file = ${TagsDir}/${BaseName}.tags"
fi
LocalVimRc=${HOME}/.vimrc
ctags_tags_mark()
{
    if [[ ${#@} -ne 1 ]]; then
        echo -e "Usage: ctags_tags_mark TagsPathname\n" 1>&2
        exit 1
    fi
    echo -n $(cat ${LocalVimRc} | grep -E 'set[[:blank:]]+tags' | grep $1)
}
if ${LZDEBUG}; then
    echo "ctags_tags_mark ${TagsDir}/${BaseName}.tags = $(ctags_tags_mark ${TagsDir}/${BaseName}.tags)"
fi
if [[ -z $(ctags_tags_mark ${TagsDir}/${BaseName}.tags) ]]; then
    echo >> ${LocalVimRc}
    echo "set tags+=${TagsDir}/${BaseName}.tags" >> ${LocalVimRc}
    echo "Registered ${TagsDir}/${BaseName}.tags into ${LocalVimRc} done."
else
    echo "${TagsDir}/${BaseName}.tags has already been registered into ${LocalVimRc}."
fi
echo -e "===>Done\n"
