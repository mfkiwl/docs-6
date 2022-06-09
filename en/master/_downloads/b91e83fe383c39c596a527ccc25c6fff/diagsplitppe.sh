#!/bin/sh

#---------------------------------------------------------------------
# diagsplitppe.sh - split diagnostic output 
#
# Usage: 
#
#   diagsplitppe.sh diagnosticsLogFile outputDir
#
# Example:
#
#   diagsplitppe.sh ./logdir/diagnostics.log ./logdir
#
#---------------------------------------------------------------------

if [ $# -eq 0 ]
then

    # Description and usage
    echo "Usage:"
    echo "  diagsplitppe.sh <diagnosticsLogFile> <outputDir>"
    echo " "
    echo "Example:"
    echo "  diagsplitppe.sh ./logdir/diagnostics.log ./logdir"

else
    # Strip out the "AAA.BBB.CCC:" prefix up to and including the first colon
    cat $1 | grep DB.WARNING | cut -d: -f2- > $2/dbwarn.txt
    cat $1 | grep DB.DEBUG.EXTRAPOLATION | cut -d: -f2- > $2/dbextrap.txt
    cat $1 | grep PE.DATA.COST_POSRTK | cut -d: -f2- > $2/pecost_sbrtk.txt
    cat $1 | grep PE.DATA.COST_A2D | cut -d: -f2- > $2/pecost_a2d.txt
    cat $1 | grep PE.DATA.MILS_COMPONENTS | cut -d: -f2- > $2/milscomponents.txt
    cat $1 | grep PE.DATA.OUTLIER | cut -d: -f2- > $2/outliers.txt
    cat $1 | grep PE.DATA.GNSS_DD_RESID_POST_POSRTK_0 | cut -d: -f2- > $2/ddresiduals_sbrtk0.txt
    cat $1 | grep PE.DATA.GNSS_DD_RESID_POST_POSRTK_1 | cut -d: -f2- > $2/ddresiduals_sbrtk1.txt
    cat $1 | grep PE.DATA.GNSS_DD_RESID_POST_A2D_1 | cut -d: -f2- > $2/ddresiduals_a2d1.txt
    cat $1 | grep DB.DATA2.DD_OBSERVABLES | cut -d: -f2- > $2/ddobservables.txt
    cat $1 | grep PS.DATA2.IMU_MEAS | cut -d: -f2- > $2/imumeas.txt
    cat $1 | grep PS.DATA2.POSE_AND_TWIST_27 | cut -d: -f2- > $2/poseandtwist27.txt
    cat $1 | grep PS.DATA2.INNOVATIONS | cut -d: -f2- > $2/pposeinnovations.txt
    cat $1 | grep PE.DATA2.DXPROP | cut -d: -f2- > $2/dxprop.txt
    cat $1 | grep PE.DATA2.ADOP | cut -d: -f2- > $2/adop.txt
fi
