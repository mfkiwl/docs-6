.. _frontend:
=========
FRONT-END
=========
Below is an *example* of the FRONT-END block: 

.. literalinclude:: ./../../../src/runtime_files/pprx.config
    :lines: 8-22

The FRONT-END block contains all of the following configuration parameters:

.. note::
   There should be three banks labeled ``[FRONT_END]``, ``[LION]``, and ``[LION_L5]``. The configuration options for ``[FRONT_END]`` are below.

NUM_FRONT_ENDS
--------------
**Default:** N/A. Required input. For RadioLion this should be set to 2.

**Definition:** The number of specified front-ends.

FE01
----
**Default:** N/A. Required input. For RadioLion this should be set to LION.

**Definition:** Which bank configurations apply to Front-End 01.

FE02
----
**Default:** N/A. Required input. For RadioLion this should be set to LION_L5.

**Definition:** Which bank configurations apply to Front-End 02.

.. note::
   The configuration options for ``[LION]`` and ``[LION_L5]`` are below.

SAMPLE_FREQ_NUMERATOR
---------------------
**Default:** N/A. Required input.

**Definition:** It is assumed that the sampling frequency of any RF front end supported by this code can be expressed in Hz as a ratio of two integers.  For example, the sampling frequency for the Zarlink/Plessey front end is 40e6/7 Hz, which would correspond to SAMPLE_FREQ_NUMERATOR = 40e6 and SAMPLE_FREQ_DENOMINATOR = 7. It is further assumed that double precision is sufficient to represent the time within a single interval of SAMPLE_FREQ_DENOMINATOR seconds.

SAMPLE_FREQ_DENOMINATOR
-----------------------
**Default:** N/A. Required input.

**Definition:** It is assumed that the sampling frequency of any RF front end supported by this code can be expressed in Hz as a ratio of two integers.  For example, the sampling frequency for the Zarlink/Plessey front end is 40e6/7 Hz, which would correspond to SAMPLE_FREQ_NUMERATOR = 40e6 and SAMPLE_FREQ_DENOMINATOR = 7. It is further assumed that double precision is sufficient to represent the time within a single interval of SAMPLE_FREQ_DENOMINATOR seconds.

QUANTIZATION
------------
**Default:** N/A. Required input.

**Definition:** The number of bits used in the front end's quantization scheme.

NUM_SUPPORTED_SIGNAL_TYPES
--------------------------
**Default:** N/A. Required input.

**Definition:** The number of signals desired to track. 

SUPPORTED_SIGNAL_TYPES
----------------------
**Default:** N/A. Required input.

**Definition:** An array listing the supported signal types. In the arrays that follow, data at the iith index correspond to the signal type at the iith index.

FREQ_IF_HZ
----------
**Default:** N/A. Required input.

**Definition:** Intermediate frequency of the signal, in Hz. See :download:`this python script <./../../../src/calc_fIF.py>` for how to calculate these numbers.

.. literalinclude:: ./../../../src/calc_fIF.py
    :linenos:
    :language: python
    :lines: 4-16, 50-64

PLL_SIGN_FPLL
-------------
**Default:** N/A. Required input.

**Definition:** Indicates high (-1) or low (1) side mixing

CODE_PHASE_BIAS_METERS
----------------------
**Default:** N/A. Required input.

**Definition:** The bias below is the amount by which a biased pseudorange exceeds its bias-free representation. Typically, the bias for SignalType GPS_L1_CA is set to zero and all other SignalTypes are referenced to this.


