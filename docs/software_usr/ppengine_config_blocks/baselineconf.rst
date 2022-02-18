.. _baselineconf:
========
BASELINE 
========

The baseline bank consists of the following configurations:


REFERENCE_ANT_STREAM
--------------------
Indicates the reference antenna by specifying the stream (i.e., ROVER or REFERENCE). 

REFERENCE_ANT_GROUP
-------------------
Indicates the reference antenna by specifying the Group (i.e., PRIMARY, ALT1, etc.).

ROVER_ANT_STREAM
----------------
Indicates the rover antenna by specifying the stream (i.e., ROVER or REFERENCE). 

ROVER_ANT_GROUP
---------------
Indicates the rover antenna by specifying the Group (i.e., PRIMARY, ALT1, etc.).

BASELINE_CONSTRAINED
--------------------
Boolean indicating if the baseline is length constrained

BASELINE_LENGTH_CONSTRAINT
--------------------------
Baseline length constraint, in meters. Enforced if :ref:`BASELINE_CONSTRAINED` = true.

BASELINE_VECTOR
---------------
Antenna baseline unit vector in the body frame for a pair of baseline constrained antennas. Only used if :ref:`BASELINE_CONSTRAINED` = true.

REFERENCE_ANT_BORESIGHT_VECTOR
------------------------------
Unit vectors pointing out the reference antenna boresight, expressed in the body frame.

ROVER_ANT_BORESIGHT_VECTOR
--------------------------
Unit vectors pointing out the rover antenna boresight, expressed in the body frame.

