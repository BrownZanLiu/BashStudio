#! /usr/bin/bash

################################################################################
# Copyright: brown.liuzan@outlook.com
# Version: 1.2
# Date: 20230329
# Description: Used to create a module template.
################################################################################

if [[ ${LIUZAN_ERRNO_SH} != "LIUZAN_ERRNO_SH_DEFINED" ]]; then
readonly LIUZAN_ERRNO_SH="LIUZAN_ERRNO_SH_DEFINED"

readonly EOK=0
readonly EPERM=1
readonly ENOENT=2
readonly ESRCH=3
readonly EINTR=4
readonly EIO=5
readonly ENXIO=6
readonly E2BIG=7
readonly ENOEXEC=8
readonly EBADF=9
readonly ECHILD=10
readonly EAGAIN=11
readonly ENOMEM=12
readonly EACCES=13
readonly EFAULT=14
readonly ENOTBLK=15
readonly EBUSY=16
readonly EEXIST=17
readonly EXDEV=18
readonly ENODEV=19
readonly ENOTDIR=20
readonly EISDIR=21
readonly EINVAL=22
readonly ENFILE=23
readonly EMFILE=24
readonly ENOTTY=25
readonly ETXTBSY=26
readonly EFBIG=27
readonly ENOSPC=28
readonly ESPIPE=29
readonly EROFS=30
readonly EMLINK=31
readonly EPIPE=32
readonly EDOM=33
readonly ERANGE=34

fi  # LIUZAN_ERRNO_SH
