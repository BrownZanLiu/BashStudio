#! /usr/bin/bash
#Brown.LiuZan@copyright
#Version: 1.1
#Date: 20190727
#Description: Used to create a utility skeletion.


#Defining section of this utility.
LZDEBUG=false
#LZDEBUG=true
#Usage checking.
if [[ $# -ne 1 ]]; then
    echo -e 'Usage:\n\tnewutl.sh scriptname' >&2
    echo -e 'Note:\n\tThe scriptname should end with ".sh".' >&2
    exit 1
fi
if [[ ! $1 =~ .+\.sh ]]; then
    echo 'The given script name should end with ".sh".' >&2
    exit 1
fi
if [[ -f $1 ]]; then
    echo "The $1 has already existed." >&2
    exit 1
fi
touch $1
chmod a+x $1
if [[ ! -x $1 ]]; then
    echo 'Failed to create and make $1 excutable.' >&2
    exit 1
fi

#Make a utility skeleton.
echo '#! /usr/bin/bash' > $1
echo '#Brown.LiuZan@copyright' >> $1
echo '#Version: 1.0' >> $1
echo "#Date: `date +%Y-%M-%d" >> $1
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
echo >> $1
echo >> $1
echo '#Main logic.' >> $1

#Starting edit.
vim $1
