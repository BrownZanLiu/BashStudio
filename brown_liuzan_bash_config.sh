# Authors: zanliu@tencent.com
# Version: 1.0
# Date: 20201102
# Copyright: cfs@csig.tencent

#Get OS ID
OS_ID=$(cat /etc/os-release | egrep "\bID\b")
OS_ID=${OS_ID#*=}
OS_ID=${OS_ID#*\"}
OS_ID=${OS_ID%\"*}

#Modify command promote format
ip=$(ip addr | grep inet | grep brd | grep 'scope global')
ip=${ip#*inet }
ip=${ip%%/*}
if [[ -n $PS1 ]]; then
    #Non-printable sequences should be enclosed in \[ and \].
    if [[ $UID -eq 0 ]]; then
        PS1="\\n\[\e[1;31m\][\\u@${ip} \\t \\w]\\n\\$ \[\e[m\]"
    else
        PS1="\\n\[\e[1;36m\][\\u@${ip} \\t \\w]\\n\\$ \[\e[m\]"
    fi
fi

#Make sure we could always access bash from /usr/bin
if [[ ! -x '/usr/bin/bash' ]]; then
    if [[ -x '/bin/bash' ]]; then
        sudo ln -s /bin/bash /usr/bin/bash
    else
        echo 'Warning: unrecognized Linux distribution and failed to setup /usr/bin/bash' >&2
    fi
fi

#Make sure font display correctness
#Show lang packs: locale -a
#export LANG="zh_CN.utf8"
export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"

#Enable coredumpe
ulimit -c unlimited

#File system travel.
alias ls='ls --color=never'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'

# git-related config
export editor=vim
export TERM='xterm-256color'

export OS_SRC_ROOT="/usr/src"
case ${OS_ID} in
'centos' | 'rocky' | 'alma' | 'tencentos')
	export OSSRC="${OS_SRC_ROOT}/kernels"
	export BCCBIN="/usr/share/bcc/tools"
	;;
'ubuntu')
	export OSSRC="${OS_SRC_ROOT}/linux-headers"
	export BCCBIN="/usr/sbin"
	;;
'*')
	;;
esac
export REPO="/repo"
export GITHUB="${REPO}/github"

PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
PATH=/usr/local/zbash/bin:${PATH}
export PATH=${BCCBIN}:${PATH}

case ${OS_ID} in
'centos' | 'rocky' | 'alma' | 'tencentos' | 'tlinux')
	alias cfspssh='pssh -t 0 -i -x StrictHostKeyChecking=no -O StrictHostKeyChecking=no -p 1024'
	alias cfspscp='pscp.pssh -t 0'
	;;
'ubuntu')
	alias cfspssh='parallel-ssh -t 0 -i -x StrictHostKeyChecking=no -O StrictHostKeyChecking=no -p 1024'
	alias cfspscp='parallel-scp -t 0'
	;;
'*')
	;;
esac
alias ossrc="cd ${OSSRC}"
alias bccbin="cd ${BCCBIN}"
alias repo="cd ${REPO}"
alias github="cd ${GITHUB}"
