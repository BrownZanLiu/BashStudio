#Brown@copyright
#Version: 1.0
#Date: 20180527
#This script services as a bash module.
#It provides OS-related information and utilities.


#Defining section of this module.
LZDEBUG=false
#LZDEBUG=true
function GetPackageManagerName()
{
    if $LZDEBUG; then
        echo "Enter into GetPackageManagerName():"
    fi

    local vManagers=(yum apt)
    if $LZDEBUG; then
        echo "Managers check list: ${vManagers[@]}"
    fi

    local vManagerName='unknown'
    if $LZDEBUG; then
        echo "Enter into checking loop:"
    fi
    for vMgr in ${vManagers[@]}; do
        vWhereisInfo=$(whereis $vMgr)
        if $LZDEBUG; then
            echo -e "\tvWhereisInfo = $vWhereisInfo"
        fi

        vRegex="$vMgr *: +/.*/$vMgr"
        if $LZDEBUG; then
            echo -e "\tvRegex = $vRegex"
        fi
        if [[ $vWhereisInfo =~ $vRegex ]]; then
            vManagerName=$vMgr
        fi
    done

    if $LZDEBUG; then
        echo "Answer:"
    fi
    echo -e "$vManagerName\c"
}


#Testing section of this module.
#LZTEST=false
LZTEST=true
if $LZTEST; then
    echo '=================Test================'
    GetPackageManagerName
    echo
    echo

    vMgr=$(GetPackageManagerName | tail -1)
    echo "Package manager name: $vMgr" 
fi
