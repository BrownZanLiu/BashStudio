#Brown@copyright
#Version: 1.0
#Date: 20180527
#This script services as a bash module.
#It provides OS-related information and utilities.


#Defining section of this module.
DODEBUG=false
#DODEBUG=true
function GetPackageManagerName()
{
    if $DODEBUG; then
        echo "Enter into GetPackageManagerName():"
    fi

    local vManagers=(yum apt)
    if $DODEBUG; then
        echo "Managers check list: ${vManagers[@]}"
    fi

    local vManagerName='unknown'
    if $DODEBUG; then
        echo "Enter into checking loop:"
    fi
    for vMgr in ${vManagers[@]}; do
        vWhereisInfo=$(whereis $vMgr)
        if $DODEBUG; then
            echo -e "\tvWhereisInfo = $vWhereisInfo"
        fi

        vRegex="$vMgr *: +/.*/$vMgr"
        if $DODEBUG; then
            echo -e "\tvRegex = $vRegex"
        fi
        if [[ $vWhereisInfo =~ $vRegex ]]; then
            vManagerName=$vMgr
        fi
    done

    if $DODEBUG; then
        echo "Answer:"
    fi
    echo -e "$vManagerName\c"
}


#Testing section of this module.
#DOTEST=false
DOTEST=true
if $DOTEST; then
    echo '=================Test================'
    GetPackageManagerName
    echo
    echo

    vMgr=$(GetPackageManagerName | tail -1)
    echo "Package manager name: $vMgr" 
fi
