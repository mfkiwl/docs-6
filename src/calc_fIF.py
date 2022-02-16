#!/usr/bin/env python3
import math

def calc_fIF(L, fTCXO, RDIV, NDIV, FDIV):
    """
    This function calculates the intermediate frequencies necessary for the options file. 
 
    Parameters:
       L: Which L-band is used as the center frequency (1), (2), or (5)
       fTCXO: (1) corresponds to 16368000 Hz and (2) corresponds to 10000000
       RDIV: Found upon plugging in the RadioLion and observing the syslog/dmesg
       NDIV: Found upon plugging in the RadioLion and observing the syslog/dmesg
       FDIV: Found upon plugging in the RadioLion and observing the syslog/dmesg
    """
    L1_fC = 1575420000;
    L2_fC = 1227600000;
    L5_fC = 1176450000;

    if L == 1:
       fC = L1_fC
    elif L == 2:
       fC = L2_fC
    elif L == 5:
       fC = L5_fC
   
    TCXO_freq = 16368000; # option 1
    MEMS_freq = 10000000; # option 2
    
    if fTCXO == 1:
       fTCXO = TCXO_freq
    elif fTCXO == 2:
       fTCXO = MEMS_freq


    fCOMP = fTCXO/RDIV
    fLO_actual = fCOMP * (NDIV + FDIV / 1048576)
    fIF_actual = fC - fLO_actual;
    print("GPS L%d IF: %.8f" %(L, fIF_actual)) 
 
calc_fIF(1, 1, 2, 192, 168357)