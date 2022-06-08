#!/usr/bin/env python3
import math

def calc_fIF():
    """
    This function calculates the intermediate frequencies necessary for the options file. 
 
    Please paste in the output of the syslog/dmesg log when plugging in the RadioLion. You can paste the 
    output directly into the appropriate configuration file for pprx. 
    """
      
    iS1 = input("Enter first dmesg log: ")
    iS2 = input("Enter second dmesg log: ")
    iS3 = input("Enter third dmesg log: ")
    iS4 = input("Enter fourth dmesg log: ")
    iS5 = input("Enter fifth dmesg log: ")
    iS6 = input("Enter sixth dmesg log: ")

    inputs = [iS1, iS2, iS3, iS4, iS5, iS6];

    fIF_actual_list = [];

    frequency = 'fC: '
    for input_string in inputs:

       start = input_string.find(frequency) + 4
       end = start + 11
       fC = input_string[start:end]

       start = end + 7
       end = start + 8
       fTCXO = input_string[start:end]

       start = end + 7
       end = start + 8
       fS = input_string[start:end]

       start = end + 9
       end = input_string.find(' ', start)
       RDIV = input_string[start:end]

       start = end + 7
       end = input_string.find(' ', start)
       NDIV = input_string[start:end]

       start = end + 7
       end = input_string.find(' ', start)
       FDIV = input_string[start:end]

       fCOMP = float(fTCXO)/float(RDIV)
       fLO_actual = fCOMP * (float(NDIV) + float(FDIV) / 1048576)
       fIF_actual = float(fC) - fLO_actual
       fIF_actual_list.append(fIF_actual)

    print("------------ L1 and L1 alt ------------") 
    print("FREQ_IF_HZ = %.6f %.6f" %(fIF_actual_list[0], fIF_actual_list[1])) 
    print("------------ L2 and L2 alt ------------") 
    print("FREQ_IF_HZ = %.6f %.6f" %(fIF_actual_list[2], fIF_actual_list[3])) 
    print("------------ L5 and L5 alt ------------") 
    print("FREQ_IF_HZ = %.6f %.6f" %(fIF_actual_list[4], fIF_actual_list[5])) 


calc_fIF()

# [11825.655957] [debug] configure_synthesizer_max2771(1641): fC: 1575420000 fTCXO: 40000000/1 fS: 20000000/2 RDIV: 3 NDIV: 117 FDIV: 1012138 FCENX: 1 FCEN: 114 FBW: 2
# [11826.314577] [debug] configure_synthesizer_max2771(1641): fC: 1575420000 fTCXO: 40000000/1 fS: 20000000/2 RDIV: 2 NDIV: 78 FDIV: 673186 FCENX: 1 FCEN: 114 FBW: 2
# [11826.974519] [debug] configure_synthesizer_max2771(1641): fC: 1227600000 fTCXO: 40000000/1 fS: 20000000/2 RDIV: 800 NDIV: 24501 FDIV: 0 FCENX: 1 FCEN: 114 FBW: 2
# [11827.634396] [debug] configure_synthesizer_max2771(1641): fC: 1227600000 fTCXO: 40000000/1 fS: 20000000/2 RDIV: 7 NDIV: 214 FDIV: 396886 FCENX: 1 FCEN: 114 FBW: 2
# [11828.294474] [debug] configure_synthesizer_max2771(1641): fC: 1176450000 fTCXO: 40000000/1 fS: 20000000/1 RDIV: 200 NDIV: 5857 FDIV: 0 FCENX: 1 FCEN: 113 FBW: 1
# [11828.954472] [debug] configure_synthesizer_max2771(1641): fC: 1176450000 fTCXO: 40000000/1 fS: 20000000/1 RDIV: 4 NDIV: 117 FDIV: 143655 FCENX: 1 FCEN: 113 FBW: 1
