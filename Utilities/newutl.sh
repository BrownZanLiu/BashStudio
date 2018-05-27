#! /usr/bin/bash
#Brown@copyright
#Version: 1.0
#Date: 20180527
#Description: Used to create a utility skeletion.


#Defining section of this utility.
DODEBUG=false
#DODEBUG=true
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
echo '#Brown@copyright' >> $1
echo '#Version:' >> $1
echo '#Date:' >> $1
echo '#Description:' >> $1
echo >> $1
echo >> $1
echo '#Defining section of this utility.' >> $1
echo '#DODEBUG=false' >> $1
echo 'DODEBUG=true' >> $1

#Starting edit.
vim $1
