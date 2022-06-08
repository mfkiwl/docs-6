#!/bin/bash
set -x
################################################################################
# File:    update_runtime_files.sh
# Purpose: Script that pulls from most recent opt/config files from gss_top. 
#
# Authors: Hailey Nichols <nichols.hailey@gmail.com>
# Created: 2022-06-08
# Version: 0
################################################################################
 
export dstdir=$(pwd)
srcdir="/Users/haileynichols/git/gss_top/run"
STRING=".config"
for srcfile in ${srcdir}/*
do 
    dstfile=$(basename $srcfile)
    if [[ "$dstfile" == *"$STRING" ]]
    then 
        echo $dstfile
        cp $srcfile $dstdir/$dstfile 
    fi
done