#!/bin/bash
set -x
################################################################################
# File:    update_txts.sh
# Purpose: Script that pulls from most recent log file defintions. 
#
# Authors: Hailey Nichols <nichols.hailey@gmail.com>
# Created: 2022-02-17
# Version: 0
################################################################################
 
export dstdir=$(pwd)
srcdir="/Users/haileynichols/git/gss_top/src/gss/doc/log_file_definitions"
for srcfile in ${srcdir}/*
do 
    dstfile=$(basename $srcfile)
    echo $dstfile
    cp $srcfile $dstdir/$dstfile 
done