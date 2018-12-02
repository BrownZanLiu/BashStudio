#! /usr/bin/bash
#Brown@copyright
#Version: 1.0
#Date: 20180527
#Description: Used to create a module skeleton.


#Defining section of this utility.
LZDEBUG=false
#LZDEBUG=true
#Usage checking.
if [[ $# -ne 1 ]]; then
    echo -e 'Usage:\n\tnewmod.sh scriptname' >&2
    echo -e 'Note:\n\tThe scriptname should end with ".sh".' >&2
    exit 1
fi
if [[ ! $1 =~ .+\.sh ]]; then
    echo 'The given script name should end with ".sh".' >&2
    exit 1
fi
if [[ -f $1 ]]; then
    echo 'The given scriptname has existed.' >&2
    exit 1
fi

#Creating and setting attributes.
touch $1
chmod a+x $1
if [[ ! -x $1 ]]; then
    echo 'Failed to create and make $1 to be excutable.' >&2
    exit 1
fi

#Making a module skeleton.
echo '#Brown@copyright' > $1
echo '#Version:' >> $1
echo '#Date:' >> $1
echo '#Description:' >> $1
echo >> $1
echo >> $1
echo '#Imports.' >> $1
echo 'source color.sh' >> $1
echo >> $1
echo >> $1
echo '#Global parameters.' >> $1
echo '#LZDEBUG=false' >> $1
echo 'LZDEBUG=true' >> $1
echo '#LZTEST=false' >> $1
echo 'LZTEST=true' >> $1
echo >> $1
echo >> $1
echo '#Module definitions.' >> $1
echo >> $1
echo >> $1
echo '#Testing section of this module.' >> $1
echo 'if $LZTEST; then' >> $1
echo 'fi' >> $1

#Starting edit.
vim $1
