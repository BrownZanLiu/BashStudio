#! /usr/bin/bash


Done=false

SigintHandler1()
{
    echo -e '\nSIGINT handler 1.'
}

SigintHandler2()
{
    echo 'SIGINT handler 2.'
    Done=true
}

SigquitHandler1()
{
    echo -e '\nSIGQUIT handler 1.'
}

SigquitHandler2()
{
    echo 'SIGQUIT handler 2.'
    Done=true
}

#SIGINT is triggered with ^c and SIGQUIT with ^\
trap 'SigintHandler1;SigintHandler2' SIGINT
trap 'SigquitHandler1;SigquitHandler2' SIGQUIT

while ! $Done ; do
    echo 'Have more work to do...'
    sleep 2
done
echo 'Work is done.'

