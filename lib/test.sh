#! /usr/bin/bash

################################################################################
# Copyright: brown.liuzan@outlook.com
# Version: 1.0
# Date: 2023-34-29
# Description:
################################################################################



if [[ '${LIUZAN_TEST_SH}' != LIUZAN_TEST_SH_DEFINED ]]; then
readonly LIUZAN_TEST_SH='LIUZAN_TEST_SH_DEFINED'



####Imports of other module files####
source lib/environments.sh
source lib/errno.sh
source lib/printer.sh


####Definition of global parameters####
gUnitTestEnabled=false


####Definition of functions####


####Unit test section####
if ${gUnitTestEnabled}; then
    print_bold_green_t "====Unit test begin===="
    print_bold_green_t "====Unit test end===="
fi



fi  # LIUZAN_TEST_SH
