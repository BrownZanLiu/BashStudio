#! /usr/bin/bash
#Brown@copyright
#Version: 1.0
#Date: 20180626
#Description: Configure user information of repository for commiting code.


#Defining section of this utility.
#DODEBUG=false
DODEBUG=true

usage()
{
	echo -e "Usage: brown-git-config.sh [l|<g>]" 1>&2
	echo -e "\n\tl\tlocal git repository setting, default" 1>&2
	echo -e "\n\tg\tglobal git repository setting" 1>&2
	echo -e "Note:\n\tIf local setting, you must run it under the root directory of a git repository." 1>&2
	exit 1
}

if [[ ${#@} -gt 1 ]]; then
	usage
elif [[ ${#@} -eq 0 ]]; then
	ARG='l'
else
	ARG=$1
fi

case ${ARG} in
	l)
		if [[ ! -d '.git' ]]; then
		   echo "This is not a git repository root directory." 1>&2
		   usage
	    fi	   
		SCOPE='local';;
	g)
		SCOPE='global';;
    **)
		usage;;
esac

git config --${SCOPE} user.name 'Brown-LiuZan'
git config --${SCOPE} user.email 'brown.liuzan@outlook.com'
git config --${SCOPE} push.default 'simple'
git config --${SCOPE} --list
