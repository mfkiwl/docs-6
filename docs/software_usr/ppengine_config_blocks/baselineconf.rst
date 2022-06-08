.. _baselineconf:
========
BASELINE 
========
The BASELINE bank consists of the following configurations:

.. literalinclude:: ./../../../src/runtime_files/a2d.config
    :lines: 1-25


REFERENCE_ANT_STREAM
--------------------
**Default:** REFERENCE

**Definition:** Indicates the reference antenna by specifying the stream (i.e., ROVER or REFERENCE). 

REFERENCE_ANT_GROUP
-------------------
**Default:** PRIMARY

**Definition:** Indicates the reference antenna by specifying the Group (i.e., PRIMARY, ALT1, etc.).

ROVER_ANT_STREAM
----------------
**Default:** ROVER

**Definition:** Indicates the rover antenna by specifying the stream (i.e., ROVER or REFERENCE). 

ROVER_ANT_GROUP
---------------
**Default:** PRIMARY

**Definition:** Indicates the rover antenna by specifying the Group (i.e., PRIMARY, ALT1, etc.).

BASELINE_CONSTRAINED
--------------------
**Default:** False

**Definition:** Boolean indicating if the baseline is length constrained

BASELINE_LENGTH_CONSTRAINT
--------------------------
**Default:** -1

**Definition:** Baseline length constraint, in meters. Enforced if :ref:`BASELINE_CONSTRAINED` = true.

BASELINE_VECTOR
---------------
**Default:** [1 0 0]

**Definition:** Antenna baseline unit vector in the body frame for a pair of baseline constrained antennas. Only used if :ref:`BASELINE_CONSTRAINED` = true.

REFERENCE_ANT_BORESIGHT_VECTOR
------------------------------
**Default:** [0 0 0]

**Definition:** Unit vectors pointing out the reference antenna boresight, expressed in the body frame.

ROVER_ANT_BORESIGHT_VECTOR
--------------------------
**Default:** [0 0 0]

**Definition:** Unit vectors pointing out the rover antenna boresight, expressed in the body frame.

