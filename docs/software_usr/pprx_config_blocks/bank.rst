.. _bank:
====
BANK
====
The BANK consists of the following configurations:

[BANK]
NUM_BANKS = 4
BK01 = GPS_L1_CA_PRIMARY
BK02 = GPS_L2_CLM_PRIMARY
BK03 = SBAS_L1_I_PRIMARY
BK04 = GALILEO_E1_BC_PRIMARY
BK05 = GPS_L1_CA_ALT1
BK06 = GPS_L2_CLM_ALT1
BK07 = SBAS_L1_I_ALT1
BK08 = GALILEO_E1_BC_ALT1

[GPS_L1_CA_PRIMARY]
FRONT_END = LION
MAXCHANNELS = 15
NUM_SUBACCUM_PER_ACCUM = 20
CODEGEN_TYPE = LOOKUP
PLL_DEFAULT_BANDWIDTH_HZ = 15
PLL_DEFAULT_LOOP_ORDER = ORDER3
EML_CHIP_SPACING = 0.2
DLL_DEFAULT_BANDWIDTH_HZ = 0.003
ALLOW_DATA_SYMBOL_PREDICTION = FALSE
DATA_SYMBOL_PULL_SNR_THRESHOLD = 19
DATA_SYMBOL_PUSH_SNR_THRESHOLD = 20
DIRECTED_ACQ_ONLY = FALSE
BACKGROUND_ACQ_ONLY = FALSE
ELEVATION_MASK_ANGLE_ACQ_DEG = 5.0
CIRCBUFF_STREAM_IDX = 0

[GPS_L1_CA_ALT1]
INHERIT_CONFIG_FROM_PRIMARY = TRUE
CIRCBUFF_STREAM_IDX = 1

*Repeat for all other signal types*

NUM_BANKS
---------
Specifies the number of signals to track. 

BK01, BK02, ...
---------------
Specifies which signal type to track in each bank.

NOM_MIN_DOPPLER_FREQ_HZ
-----------------------
Nominal minimum Doppler frequency used in the carrier replica array
 
NOM_MAX_DOPPLER_FREQ_HZ
-----------------------
Nominal maximum Doppler frequency used in the carrier replica array

DOPPLER_FREQ_STEP_HZ
--------------------
Doppler frequency step used in the carrier replica array

NOM_CHIPRATE_CPS
----------------
Nominal chipping rate of PRN code, in chips per second

FREQ_CARRIER_HZ
---------------
Nominal carrier frequency, in Hz

EML_CHIP_SPACING
----------------
Spacing between early and late correlators, in chips

NUM_CHIPS_PER_SUBACCUM
----------------------
Number of chips per subaccumulation. ``NUM_CHIPS_PER_SUBACCUM`` must be an integer divisor of the number of chips in a PRN code cycle (:ref:`NUM_CHIPS_PER_CODE`).

NUM_CHIPS_PER_CODE
------------------
Number of chips in PRN code

NUM_SUBACCUM_PER_SYMBOL
-----------------------
Number of subaccumulations per symbol

MAXCHANNELS
-----------
Maximum number of channels that the Bank object is allowed to have.

NUM_SUBACCUM_PER_ACCUM
----------------------
Integer number of subaccumulation intervals per accumulation interval. If the signal to be tracked is data modulated, then ``NUM_SUBACCUM_PER_ACCUM`` must be an integer divisor of the number of subaccumulations per data symbol (:ref:`NUM_SUBACCUM_PER_SYMBOL`).

CH_IQSQ_FILTER_TAU_SEC
----------------------
Time constant for the low-pass filter that smoothes the one-C/A-code-period I^2 + Q^2 quantities to get E[I^2 + Q^2]

CH_DISTORTION_FILTER_TAU_SEC
----------------------------
As with the I^2 + Q^2 filter, the symmetric difference distortion statistic filter is a digitized low-pass filter.

CH_PRUNE_INTERVAL_SEC
---------------------
Nominal pruning interval, in seconds

CH_PRUNE_THRESHOLD
------------------
Number of consecutive times a signal must fail the pruning criteria, which is called every :ref:`CH_PRUNE_INTERVAL_SEC`, before it gets pruned.

CH_PRUNE_CN0_THRESHOLD_MIN
--------------------------
Minimum C/N0 thresholds for pruning signals, in dB-Hz.

CH_PRUNE_CN0_THRESHOLD_MAX
--------------------------
Maximum C/N0 thresholds for pruning signals, in dB-Hz.

MAX_ACQ_SEARCH_DEPTH
--------------------
Maximum acquisition search depth

MAX_DIRECTED_STANDARD_ACQ_ATTEMPTS_PER_CYCLE
--------------------------------------------
Maximum number of directed standard acquisition attempts allowed per acquisition cycle.

FLOORED_RADIX2_FFT_ACQ_SIZE
---------------------------
Default = false. With radix-2-only FFT libraries, samples are interpolated to next radix-2 size. If ``FLOORED_RADIX2_FFT_ACQ_SIZE`` is set, the interpolation size is the previous radix-2 size, improving computational performance but also reducing bandwidth and causing aliasing.

DIRECT_TO_TRACK_ACQ_INITIAL_CN0_DB_HZ
-------------------------------------
C/N0 estimate used as an initial guess when initializing a channel via direct-to-track acquisition.

DIRECTED_ACQ_ONLY
-----------------
Allow only directed acquisition (direct-to-track acquisition or directed standard acquisition) after initial acquisition. Note that this flag gets overridden when too few root bank signals have been acquired. The override feature ensures that processing power gets devoted to standard acquisition upon startup or after a complete loss of signals when directed acquisition isn't yet operable.

DIRECT_TO_TRACK_ACQ_ONLY
------------------------
Allow only direct-to-track acquisition after initial acquisition. Note that this is more restrictive than :ref:`DIRECTED_ACQ_ONLY`, which allows direct-to-track acquisition or directed standard acquisition. A runtime error will be thrown if this option is asserted simultaneously with :ref:`DIRECTED_STANDARD_ACQ_ONLY`; they are mutually exclusive.

DIRECTED_STANDARD_ACQ_ONLY
--------------------------
Allow only directed standard acquisition after initial acquisition. Note that this is more restrictive than :ref:`DIRECTED_ACQ_ONLY`, which allows direct-to-track acquisition or directed standard acquisition. A runtime error will be thrown if this option is asserted simultaneously with :ref:`DIRECT_TO_TRACK_ACQ_ONLY`; they are mutually exclusive.

BACKGROUND_ACQ_ONLY
-------------------
Allow only background acquisition; prevent initial acquisition

DISABLE_STANDARD_ACQ
--------------------
Disable standard acquisition during background acquisition. This directive will not be overriden under any circumstance. Note that standard acquisition may be performed during initial (exhaustive) acquisition if :ref:`BACKGROUND_ACQ_ONLY` is false.

FORCE_HEALTHY_WHEN_TRACQUIRED
-----------------------------
Denote signal as healthy when tracquired so there is no need to wait for the signal's embedded health indicator to arrive (e.g., in subframe 1 for GPS L1 C/A) before the signal can participate in a navigation solution. (Note that this option typically only applies when ephemeris are imported, since tracquisition is not attempted for signals marked unhealthy. Imported ephemeris do not indicate health status.) The temporary healthy indication forced by this option will be overridden by the signal-borne health indicator as soon as it arrives.

FORCE_HEALTHY
-------------
Signals marked unhealthy may still be useful.  When this flag is asserted, all signals in the corresponding bank will be marked healthy.

ELEVATION_MASK_ANGLE_ACQ_DEG
----------------------------
Elevation mask angle for acquisition, in radians. Signals arriving at the receiver from transmitters below the elevation mask angle will be excluded from direct-to-track acquisition. Set to -PI/2 to prevent elevation masking. In the receiver config file, the elevation mask angle is given in degrees as ``ELEVATION_MASK_ANGLE_ACQ_DEG``.

BORESIGHT_ELEVATION_MASK_ANGLE_ACQ_RAD
--------------------------------------
Boresight-relative elevation mask angle for acquisition, in radians. See ELEVATION_MASK_ANGLE_ACQ_RAD.

PLL_DEFAULT_BANDWIDTH_HZ
------------------------
Default PLL bandwidth, in Hz.

PLL_DEFAULT_LOOP_ORDER
----------------------
Possible closed-loop loop orders for phase tracking loops. Select from the following options:

- ``ORDER1`` 
- ``ORDER2``
- ``ORDER3``

PLL_HYBRID_BANDWIDTH_HZ
-----------------------
Hybrid PLL bandwidth, in Hz.

PLL_HYBRID_LOOP_ORDER
---------------------
Possible closed-loop loop orders for phase tracking loops. Select from the following options:

- ``ORDER1`` 
- ``ORDER2``
- ``ORDER3``

PLL_DEFAULT_DISCRIMINATOR_TYPE
------------------------------
Types of phase tracking loop discriminators. Select from the following options:

- ``AT_DISC``: Two-quadrant arctangent:  atan(Q/I)
- ``AT4_DISC``: Four-quadrant arctangent: atan2(Q,I)

TRACKING_STRATEGY
-----------------
Signal tracking strategy. Select from the following options:

- ``TRADITIONAL``: Traditional fll/pll/dll tracking loops
- ``HYBRID``: Vector-aided fll/pll/dll tracking loops
- ``VECTOR``: Fully vectorized tracking with batch superaccumulation fitting
- ``DEEP``: Fully vectorized tracking with batch superaccumulation fitting and IMU aiding at the lowest level


NOISE_FLOOR_CORRECTION_FACTOR
-----------------------------
Set greater than unity to correct for thermal noise floor underestimation that occurs when the incoming data samples are time correlated. Values less than unity are considered invalid.

PLL_PHASE_LOCK_THRESHOLD
------------------------
The PLL's phase lock threshold is compared against the phase lock statistic in Equation 118 on page 393 of the Blue Book, volume 1.

PLL_PHASE_FLAG_THRESHOLD
------------------------
Determines when a phase lock flag is raised to indicate possible cycle slippage

PLL_NUM_SUB_PER_PHASELOCK
-------------------------
Number of subaccumulations per phase lock detection interval.

PLL_ENABLE_LOOP_BANDWIDTH_ADAPTATION
------------------------------------
Indicates whether dynamic loop bandwidth adaptation (based in signal power) is enabled for the PLL.

PLL_FREQ_UPDATE_ON_SILENCE
--------------------------
Set to true to allow the PLL to update the frequency estimate during intervals of known transmitter silence (applicable to TDMA signals).

DLL_DEFAULT_BANDWIDTH_HZ
------------------------
Default DLL bandwidth, in Hz.

DLL_CARRIER_AIDING
------------------
Specifies whether the DLL is aided by the carrier tracking loop.

ALLOW_DATA_SYMBOL_PREDICTION
----------------------------
If true, data symbol estimates for purposes of data symbol wipeoff and data parsing and interpretation may be based on predicted values from DatabitManager. If false, data symbol estimates are based only on immediately measured symbol values.

DATA_SYMBOL_PULL_SNR_THRESHOLD
------------------------------
Thresholds governing behavior of data symbols pushed and pulled from DataBitManager. Thresholds are expressed as a signal-to-noise ratio in dB. SNR is defined for the symbol interval so that SNR = Tsym*C/N0, where Tsym is the symbol interval. For example, if Tsym = 0.02, then SNR = 20 dB corresponds to C/N0 = 37 dB-Hz.

DATA_SYMBOL_PUSH_SNR_THRESHOLD
------------------------------
Thresholds governing behavior of data symbols pushed and pulled from DataBitManager. Thresholds are expressed as a signal-to-noise ratio in dB. SNR is defined for the symbol interval so that SNR = Tsym*C/N0, where Tsym is the symbol interval. For example, if Tsym = 0.02, then SNR = 20 dB corresponds to C/N0 = 37 dB-Hz.

EXPORT_DATA_BIT_BLOCKS
----------------------
When asserted, each block of received and error-checked data bits will be exported to the internal GBX stream.  The definition of a block differs by SignalType:GenericType. For GPS_L1_CA, it is an LNAV frame. For SBAS_L1_I, it is a 1-second block.

CIRCBUFF_STREAM_IDX
-------------------
Index of circular buffer stream this bank should use.

FLL_NOM_BANDWIDTH_HZ
--------------------
Nominal FLL bandwidth, in Hz.

FLL_WEAK_BANDWIDTH_HZ
---------------------
Weak-signal FLL bandwidth, in Hz.

FLL_DEFAULT_LOOP_ORDER
----------------------
Possible closed-loop loop orders. Select from the following options:

- ``ORDER1`` 
- ``ORDER2``
- ``ORDER3``

FLL_NBS1_NOM, FLL_NBS1_WEAK
---------------------------
Upper thresholds for the histogram-based data bit synchronization process, nominal-strength and weak signals.  See details in Blue Book volume 1 p. 395.

FLL_NBS2_NOM, FLL_NBS2_WEAK
---------------------------
Lower thresholds for the histogram-based data bit synchronization process, nominal-strength and weak signals.  See details in Blue Book volume 1 p. 395.

FLL_FREQ_UPDATE_ON_SILENCE
--------------------------
Set to true to allow the FLL to update the frequency estimate during intervals of known transmitter silence (applicable to TDMA signals).

TXID_LIST
---------
List of TxIds valid for bank. If this list is empty, then all TxIds for the bank's system are assumed valid.

CODEGEN_TYPE
------------
Type of oversampled code generators. Select from the following options:

- ``NONE``
- ``LOOKUP``
- ``PSIAKI``
- ``FULL_PRECISION``
- ``MULTI_TAP``

MSAMPFRAC
---------
Parameter governing the adjustment resolution of oversampled code replicas: an oversampled code will have MSAMPFRAC levels of adjustment per sample.  Thus, the location of the first sample within a code can be specified to within the sampling interval divided by MSAMPFRAC of the desired location.

NUM_TAPS, PROMPT_TAP, EARLY_TAP, LATE_TAP
-----------------------------------------
Parameters for the multi-tap generator

