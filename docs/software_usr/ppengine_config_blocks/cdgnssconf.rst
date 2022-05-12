.. _cdgnssconf:
======
CDGNSS 
======
The cdgnss bank consists of the following configurations:

.. .. image:: ./../../images/lionbank.png
..    :width: 60 %
..    :align: center

USE_IONO_CORR
-------------
Default = true
Set true to correct for ionospheric delay when estimating the state

USE_TROPO_CORR
--------------
Default = true
Set true to correct for tropospheric (neutral atmospheric) delay when estimating the state

ILS_NUM_THREADS
---------------
Sets the number of threads ILS is allowed to use for modes capable of parallelization (e.g., grid search).

IA_TEST_TYPE
------------
Specifies the type of Integer Aperture test to be performed. Select from the following options:

+ ``IALS``
+ ``RATIO``
+ ``DIFFERENCE``

IA_OVERRIDE_TEST_RESULT
-----------------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = false
Allows for the Integer Aperture test to be effectively disabled by overriding the output with overrideValue so that all fixed or all float results can be seen. The test will still be performed so that all statistics from the test can be viewed, but the returned result is fixed regardless of the test result.

IA_OVERRIDE_VALUE
-----------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = false

IA_USE_FIXED_FAILURE_RATE
-------------------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = true
Allows fixed-failure-rate testing to be turned off with the test parameter set to a fixed default value

IA_DEFAULT_TEST_PARAM
---------------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = 0.8
Sets the default parameter that is used when not using the fixed-failure rate test

IA_ALLOWABLE_FAILURE_PROBABILITY
--------------------------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = 1e-3
Sets the maximum allowable failure probability for the fixed-failure rate test. Note that some of the Integer Aperture tests have fixed-failure rate algorithms that look up model coefficients from a table based (at least partially) on this failure rate. In these cases, the failure rate is rounded down to the nearest entry in the table. If the specified failure rate is lower than all values in the table, then the Integer Aperture test will throw an ASSERT on configuration.

IA_MINIMUM_TEST_PARAM
---------------------
Additional configuration for selected integer aperture test in configuration parameter :ref:`IA_TEST_TYPE`.
Default = -INFINITY
Sets the minimum test statistic that is allowed when using the fixed-failure rate test. This helps to protect against cases when the fixed-failure rate test sets a low or zero threshold due to an overly optimistic high model strength, often caused by unmodeled biases such as multipath.

USE_POINT_REPELLING_MODEL
-------------------------
Default = false
Production of the spherical grid used in constrained baseline ILS can employ a point repelling model to refine the grid points by making them more uniformly spaced. However, this model can take a while to run for baselines longer than 1 meter. Only relevant to the ATTITUDE_2D estimator.

SPHERE_GRID_SPACING_MULT
------------------------
Default = 0.95
The spherical grid used in constrained baseline ILS requires grid points to be spaced by no more than half the smallest wavelength (L1 wavelength). However, it is usually a good idea to try for a little tighter than this because it is theoretically provable that uniform spacing on a sphere is impossible, past a certain number of points, and our algorithms for producing the grid are just an approximation. This value is a multiplication factor of LAMBDA_L1_M/2 to determine the goal grid spacing. Value cannot be larger than 1 or less than or equal to 0. Only relevant to the ATTITUDE_2D estimator.

ELEVATION_MASK_ANGLE_RAD
------------------------
Default = 0.25
Elevation mask angle, in radians. Signals arriving at the receiver from transmitters below the elevation mask angle will be excluded from the estimation solution. Set to -PI/2 to prevent elevation masking. In the receiver config file, the elevation mask angle is given in degrees as ELEVATION_MASK_ANGLE_DEG.

BORESIGHT_ELEVATION_MASK_ANGLE_RAD
----------------------------------
Default = -INFINITY
Boresight-relative elevation mask angle, in radians. See :ref:`ELEVATION_MASK_ANGLE_RAD`. This value is only used when vehicle attitude information is provided in the incoming GBX stream.

ENFORCE_STRICT_SELECTION
------------------------
Default = true
When true, carrier phase and pseudorange measurements associated with a phase lock statistic below :ref:`STRICT_SELECTION_PHASE_LOCK_STAT_THRESHOLD` or C/N0 values below :ref:`STRICT_SELECTION_CN0_THRESHOLD` will be excluded from the precise navigation solution. When false, such measurements will be permitted.

STRICT_SELECTION_CN0_THRESHOLD
------------------------------
Default = 37.5
Carrier-to-noise ratio threshold for strict selection. See comments for :ref:`ENFORCE_STRICT_SELECTION`.

STRICT_SELECTION_PHASE_LOCK_STAT_THRESHOLD
------------------------------------------
Default = 0.55
Phase lock statistic threshold for strict selection. See comments for :ref:`ENFORCE_STRICT_SELECTION`.

INNOVATIONS_TEST_PF
-------------------
Default = 1e-5
Threshold for double-difference pseudorange innovations test. (also known as the "float" innovations test). The innovations test is a chi-squared test using the normalized innovations squared (NIS) statistic, with a threshold corresponding to a constant false alarm rate of INNOVATIONS_TEST_PF. If the test is failed for a batch of DD GNSS observables, the POSITION_RTK and ATTITUDE_2D estimators reinitialize themselves. The POSE_AND_TWIST estimators reject that batch of observables but do not reinitialize.

FIX_INNOVATIONS_TEST_PF
-----------------------
Default = 1e-5
Threshold for double-difference carrier phase innovations test. (also known as the "fix" innovations test). The innovations test is a chi-squared test using the normalized innovations squared (NIS) statistic, with a threshold corresponding to a constant false alarm rate of FIX_INNOVATIONS_TEST_PF. Carrier phase NIS is approximated as chi-square distributed, but this not exactly the case because large residuals "tick over" to the next integer (therefore, large carrier phase residuals are not possible). If the test is failed for a batch of DD GNSS observables, the estimator falls back to a float solution (equivalent to a pseudorange-only solution when performing single-epoch integer ambiguity resolution)

DD_PSEUDORANGE_SCALAR_OUTLIER_THRESH_STD
----------------------------------------
Default = +INFINITY
Threshold, in standard deviations, for scalar DD pseudorange outlier rejection. If the scalar normalized innovations value for a DD pseudorange measurement exceeds this threshold, the corresponding GNSS satellite is excluded on all frequencies for all baselines.

See the section titled "Outlier Rejection using Pseudorange Innovations" in `this paper <https://radionavlab.ae.utexas.edu/wp-content/uploads/2022/02/tight-coupling-journal.pdf>`_.


SOFT_RESET_NIS_HISTORY_WINDOW
-----------------------------
Default = 0
Window size, in epochs, of the false fix detection and recovery mechanism. If the double-difference carrier phase normalized innovations squared (NIS) over this window exceeds a chi-squared test threshold, a "soft reset" is performed, falling back to the "float-only" estimator. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

See the section titled "False fix detection and recovery" in `this paper <https://radionavlab.ae.utexas.edu/wp-content/uploads/2022/02/tight-coupling-journal.pdf>`_.

SOFT_RESET_TEST_PF
------------------
Default = 1e-5
False-alarm probability used to set the false-fix detection chi-squared threshold. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

SOFT_RESET_MIN_NUM_FIXES_IN_WINDOW
----------------------------------
Default = 5
The false fix detector will only be able to fire if there have been at least SOFT_RESET_MIN_NUM_FIXES_IN_WINDOW integer fixes in the rolling window. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

ALLOW_RESEED
------------
Default = true
Enable the "re-seed" mechanism of the POSE_AND_TWIST_15_MULTI_MODEL estimator. If the re-seed criteria are met, the "float-only" estimator state will be "re-seeded" with the latest integer fixed solution. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

See the section titled "Float-only estimator re-seeding" in `this paper <https://radionavlab.ae.utexas.edu/wp-content/uploads/2022/02/tight-coupling-journal.pdf>`_.

RESEED_LAST_FIX_NIS_THRESHOLD
-----------------------------
Default = 1.0
Maximum (Carrier phase NIS / # carrier phase measurements) for the most recent fixed-integer solution to permit a re-seed. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

RESEED_LAST_WINDOW_NIS_THRESHOLD
--------------------------------
Default = 0.5
Maximum (window carrier phase NIS / # carrier phase measurements in window) for a re-seed. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

RESEED_LAST_FIX_MIN_NDD
-----------------------
Default = 10
A re-seed is only performed if there were at least RESEED_LAST_FIX_MIN_NDD double-difference measurements used in the most recent fixed solution. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

RESEED_MIN_FIXES_IN_WINDOW
--------------------------
Default = 10
A re-seed is only performed if there were at least RESEED_MIN_FIXES_IN_WINDOW fixed solutions in the rolling window used by the false fix detector. Only used by the POSE_AND_TWIST_15_MULTI_MODEL estimator.

SQRT_Q_TILDE_POS
----------------
Default = 0.2
The position process noise for some dynamics models is expressed in terms of SQRT_Q_TILDE_POS, the square root of the noise intensity. See Bar Shalom "Estimation with Applications to Tracking and Navigation" sections 6.2.1 to 6.2.3 for details. The units of SQRT_Q_TILDE_POS are as follows for each dynamics model:

STATIC                          meters/sqrt(sec)
NEARLY_CONSTANT_VELOCITY        meters/sqrt(sec^3)
INERTIAL_MEASUREMENT_UNIT       meters/sqrt(sec^3)
NEARLY_CONSTANT_ACCELERATION    meters/sqrt(sec^5)

SQRT_Q_TILDE_POS represents the standard deviation of error induced on position, velocity, or acceleration state elements by the process noise over a 1-second propagation step. The standard deviation corresponding to a T-second step is then approximated as sigmaX = sqrt(T)*SQRT_Q_TILDE_POS (see, e.g., Eq. 6.22-13 in Bar Shalom). This approximation is valid for short T; for long T, one needs to take multiple short propagation steps. Note that SQRT_Q_TILDE_POS is only used to generate a Q matrix for the INERTIAL_MEASUREMENT_UNIT dynamics model to cover any propagation step that may be required between thelatest IMU measurement before the measurement update and the measurement update itself.

SQRT_Q_TILDE_BODY_VEC
---------------------
|Default = 0 0 0 
|SQRT_Q_TILDE_BODY_VEC represents the standard deviation of error induced on position, velocity, or acceleration state elements by the process noise over a 1-second propagation step, in the body X (nominally aligned with forward motion), Y (lateral), and Z (up) directions. This configuration option is used in place of SQRT_Q_TILDE when the BODY_NEARLY_CONSTANT_VELOCITY dynamics model is employed. It allows a simple way to constrain vehicle motion in the lateral and up directions.

SQRT_Q_TILDE_ATT
----------------
Default = 0.05
The attitude corollary to :ref:`SQRT_Q_TILDE_POS` is SQRT_Q_TILDE_ATT. The units of this quantity depend on if the state includes angular velocity or not and are as follows

no angular velocity      rad/sqrt(sec)
with angular velocity    rad/sqrt(sec^3)

SQRT_Q_TILDE_ATT_VEC
--------------------
Default = 0.05 0.05 0.05. See :ref:`SQRT_Q_TILDE_ATT`.

UNDIFFERENCED_ZENITH_PSEUDORANGE_STD
------------------------------------
Default = 1.0
Standard deviation of undifferenced pseudorange measurements assuming a transmitter at zenith, in meters. This value applies for all frequencies.

UNDIFFERENCED_ZENITH_PHASE_STD
------------------------------
Default = 0.004
Standard deviation of undifferenced carrier phase measurements assuming a transmitter at zenith, in meters. This value applies for all frequencies.

UNDIFFERENCED_ZENITH_STATIONARY_PSEUDORANGE_STD
-----------------------------------------------
Default = 5
Standard deviation of the undifferenced pseudorange measurements while rover is stationary, assuming a transmitter at zenith, in meters. This value can be set larger than UNDIFFERENCED_ZENITH_PSEUDORANGE_STD to account for the increased multipath that stationary rover antennas suffer. If unspecified by the user, this parameter defaults to the same value as UNDIFFERENCED_ZENITH_PSEUDORANGE_STD. Stationarity is determined using the velocity component of the rover standard navigation solution.

UNDIFFERENCED_ZENITH_TRANSIENT_PSEUDORANGE_STD
----------------------------------------------
Default = 1
Alternate undifferenced pseudorange standard deviation at zenith, in meters, that is used during the FIRST_TRANSIENT period of the DLL.


ELEVATION_DEPENDENT_WEIGHTING
-----------------------------
Default = true.
Assert to weight undifferenced observables by 1/sin(el), where el is the elevation angle.  This has the effect of de-weighting multipath-corrupted low-elevation signals.  If not asserted, all observables are weighted equally.

OUTLIER_DETECTION
-----------------
Default = false.
Perform outlier detection on pseudorange and carrier phase measurements assuming (A) that the ratio test is passed and (B) that the minimum number of DD carrier phase measurements exceeds :ref:`MINIMUM_NUMBER_DD_SIGNALS_FOR_OUTLIER_DETECTION`. Multiple outliers can be detected during each epoch, if necessary.

MINIMUM_NUMBER_DD_SIGNALS_FOR_OUTLIER_DETECTION
-----------------------------------------------
Default = 8
If :ref:`OUTLIER_DETECTION` = true, continue to perform outlier detection on signals until the number of carrier phase measurements drops below this threshold.

MINIMUM_NUMBER_DD_SIGNALS
-------------------------
Default = 1
Minimum number of double-differenced (DD) signal pairs required to promote a float solution to a fixed solution.  If the most recent solution was a fixed solution, then this minimum is ignored, unless :ref:`FORCE_NDD_REQUIREMENT` is TRUE.

FORCE_NDD_REQUIREMENT
---------------------
Default = false
If FALSE, a fixed solution with NDD less than :ref:`MINIMUM_NUMBER_NDD_SIGNALS` will still be accepted if the previous solution was fixed and certain other criteria are met. If TRUE, :ref:`MINIMUM_NUMBER_NDD_SIGNALS` is strictly enforced.

MAXIMUM_AGE_OF_VALID_REFERENCE_DATA_SEC
---------------------------------------
Default = 0.5
Maximum allowed age of reference data relative to current rover epoch for the reference data to be considered valid. Note that if the reference data are more recent than the rover data, then the age will be negative and will always be less than the value below, which is assumed to be positive. Note also that if one sets this value smaller than the reference data's inter-epoch interval Te then, for each rover epoch processed, the age of data aod will be on the range -Te < aod <= 0.  Thus, one should choose Te to be an acceptably small age of data.


REFERENCE_ECEF_POSITION
-----------------------
Precise XYZ ECEF position of the mean L1 phase center of the static reference antenna used in single-baseline RTK, expressed in meters in the same coordinates as the ephemeris records. The Boolean component indicates validity.

ROVER_ECEF_POSITION
-------------------
Precise XYZ ECEF position of the mean L1 phase center of a static rover receiver antenna used in single-baseline RTK, expressed in meters in the same coordinates as the ephemeris records. The Boolean component indicates validity.

CONSTRAIN_ROVER_ECEF_POSITION
-----------------------------
Default = false
Indicates whether the rover antenna position should be constrained to the value :ref:`ROVER_ECEF_POSITION`.

CONSTRAINT_SIGMA_METERS
-----------------------
Default = 1e-4
The rover antenna constraint, in meters. If CONSTRAIN_ROVER_ECEF_POSITION is asserted, then an artificial constraint with a standard deviation of CONSTRAINT_SIGMA_METERS will tie the rover position to :ref:`ROVER_ECEF_POSITION`.

CONSTRAIN_ROVER_TO_TRUTH_POSITION
---------------------------------
Default = false
If true, constrains the rover to positions supplied via incoming "truth" PoseAndTwist GBX messages. This option requires the STATIC dynamics model.

TRUTH_POSITION_OFFSET_ENU
-------------------------
ENU frame offset added to incoming "truth" PoseAndTwist messages

ADMISSIBLE_GENERIC_TYPES
------------------------
To avoid mismatched double differences, only a single SignalType:GenericType is admissible for each System at each center frequency. For example, at L2 only one of GPS_L2_CL, GPS_L2_CM, or GPS_L2_CLM is allowed. The following vector lists all admissible GenericTypes.
.. .. code-block:: c
.. 	std::vector<SignalType::GenericType> ADMISSIBLE_GENERIC_TYPES{
..     SignalType::GPS_L1_CA, SignalType::SBAS_L1_I, SignalType::GALILEO_E1_BC,
..     SignalType::GPS_L2_CLM
..   };

TXID_EXCLUDE_LIST
-----------------
List of TxIds and frequencies to exclude from participating in PpEstimator solution.  Each element in the list is entered by the user according to the format

[Alphabetic System Designator][Number][Frequency Code]

The alphabetic system designator is the same as the RINEX convention: G (GPS), E (Galileo), S (SBAS), etc.  The frequency code is either L1 or L2.  For example, to exclude GPS PRN 23 only on L2, Galileo PRN 13 on all frequencies, and SBAS PRN 138 on L1:

TXID_EXCLUDE_LIST G23L2 E13L1 E13L2 S138L1

FORCE_PIVOT_LIST
----------------
List of TxIds and frequencies that are commanded to be used as pivots in double differencing. The input format is the same as for :ref:`TXID_EXCLUDE_LIST`.  If this list is empty, then pivots will be chosen according to the default internal algorithm.

GALILEO_E1_BC_TO_GPS_L1_CA_DD_DCB
---------------------------------
Default = 0
Differential code bias in the double difference pseudorange observation for a pivot satellite with GenericType GPS_L1_CA and a non-pivot satellite with the GenericType indicated.  If the pivot and non-pivot roles are reversed, then the negative of this DCB value is applied. This type of DCB arises when the rover receiver and the reference receiver have dissimilar front ends or code replica generator configuration.

SBAS_L1_I_TO_GPS_L1_CA_DD_DCB
-----------------------------
Default = 0
Differential code bias in the double difference pseudorange observation for a pivot satellite with GenericType GPS_L1_CA and a non-pivot satellite with the GenericType indicated.  If the pivot and non-pivot roles are reversed, then the negative of this DCB value is applied. This type of DCB arises when the rover receiver and the reference receiver have dissimilar front ends or code replica generator configuration.

FORCE_VALID_REFERENCE_OBSERVABLES
---------------------------------
Default = false
Observables from GRID/pprx are marked invalid if the transmitter is indicated to be unhealthy, or if the health status is not known.  When the following flag is asserted, all processed observables from the reference stream are considered valid. Rover stream observables are never forced valid; their validity can only be overriden by appropriate pprx configuration.

OUTLIER_EXCLUSION_DEPTH
-----------------------
Default = 0
Depth of outlier exclusion search.  Signals are ordered from most to least likely to cause integer fixing failure and single-signal (N-choose-1) exclusion is attempted on each of the ordered signals up to and including the nth one, with n = OUTLIER_EXCLUSION_DEPTH.  A value of 0 prevents outlier exclusion from being performed. 
  
BACKWARD
--------
Default = false
When true, the estimator is configured to run backward in time. Setting this parameter to true merely configures the estimator to expect and operate on a time-reversed data stream. It does not cause a normal data stream to be reversed.

A2D_MAX_ELEVATION_FOR_INTEGER_INITIAL_GUESS_RAD
-----------------------------------------------
Default = -1
Initial relative position guesses will be confined to +/- this elevation value, which should be positive, in radians. A value of -1 indicates that no elevation constraint should be applied.

A2D_SOLUTION_ELEVATION_MASK_RAD
-------------------------------
Default = PI/2
If the solution lies outside the region +/- this threshold the integrityCheckPassed flag will be lowered. This parameter should be positive and in radians. A value of -1 indicates that no elevation threshold should be applied to the attitude solution. 

USE_UNSCENTED_UPDATE
--------------------
Default = true

DISABLE_AFTER_PPOSE_INIT
------------------------
Default = false
If TRUE, this estimator will stop consuming incoming GBX reports whenever the attached PPose reports it is initialized. (this is a measure to save CPU usage when using PosRTK/A2D only for PPose initialization)

POS_PRI_ANTENNA_B
-----------------
Default = 0 0 0
Position of the PRIMARY GNSS antenna in the body frame. Used for antenna combining and inertial aiding of the POSITION_RTK solution. Only used by POSITION_RTK.

POS_ALT1_ANTENNA_B
------------------
Default = 0 0 0
Position of the ALT_1 GNSS antenna in the body frame. Used for antenna combining and inertial aiding of the POSITION_RTK solution. Only used by POSITION_RTK.

POS_IMU_B
---------
Default = 0 0 0
Position of the IMU in the body frame. Used for inertial aiding of the POSITION_RTK solution. Only used by POSITION_RTK.

DO_ANTENNA_COMBINING
--------------------
Default = false
If true, attitude-aided antenna combining is performed by POSITION_RTK using a fixed a priori vehicle attitude given by incoming MEASUREMENTS GBX reports. Only used by POSITION_RTK.

ANTENNA_COMBINING_BODY_FRAME_BIAS_STATE
---------------------------------------
Default = false
If true, an additional additive bias to POS_ALT1_ANTENNA_B is estimated online when performing antenna combining in POSITION_RTK. This bias is modeled as an Ornstein-Uhlenbeck process with the given steady-state uncertainty and time constant. Only used by POSITION_RTK.

ANTENNA_COMBINING_BODY_FRAME_BIAS_UNCERTAINTY_M
-----------------------------------------------
Default = NaN

ANTENNA_COMBINING_BIAS_TIME_CONSTANT_SEC
----------------------------------------
Default = NaN

CONDITION_ON_FIXED_SOLUTION
---------------------------
Default = true
If FALSE, a fixed solution (if available) will be reported in the GBX output, but only the float solution will be committed to the filter state. Only used by POSITION_RTK.

MAX_VERTICAL_SEPARATION_FOR_FIX
-------------------------------
Default = +INFINITY
If the vertical separation between the reference and rover (in meters) (determined by the rover's standard navigation solution) is greater than this threshold, an integer fix is not attempted. Only used by POSITION_RTK.

MAX_HORIZONTAL_SEPARATION_FOR_FIX
---------------------------------
Default = +INFINITY
If the horizontal separation between the reference and rover (in meters) (determined by the rover's standard navigation solution) is greater than this threshold, an integer fix is not attempted. Only used by POSITION_RTK.

VERTICAL_SEPARATION_FOR_RESET
-----------------------------
Default = +INFINITY
If this configuration option is set, an estimator reset is performed if the vertical separation between the reference and rover (in meters) as determined by the rover's standard navigation solution is between VERTICAL_SEPARATION_FOR_RESET and VERTICAL_SEPARATION_FOR_RESET+200.