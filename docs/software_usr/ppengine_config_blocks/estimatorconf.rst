.. _estimatorconf:
=========
ESTIMATOR 
=========
Below is an *example* of the ESTIMATOR block: 

.. literalinclude:: ./../../../src/runtime_files/a2d.config
    :lines: 26-29
    
The ESTIMATOR block contains all of the following configuration parameters:

ALPHA
-----
**Default:** 1e-3

**Definition:** Standard sigma point filter parameter alpha that governs the reach of the sigma points around the current best estimate

BETA
----
**Default:** 2

**Definition:** Standard sigma point filter parameter beta that governs the reach of the sigma points around the current best estimate

KAPPA
-----
**Default:** 0

**Definition:** Standard sigma point filter parameter kappa that governs the reach of the sigma points around the current best estimate

DYNAMICS_MODEL
--------------
**Default:** STATIC

**Definition:** Assumed relative vector dynamics model, used by PositionRtk and Attitude2D estimators. (PoseAndTwist estimators require an IMU). Select from the following options:

	* ``STATIC``
	* ``NEARLY_CONSTANT_VELOCITY``
	* ``NEARLY_CONSTANT_ACCELERATION``
	* ``BODY_NEARLY_CONSTANT_VELOCITY`` Applies a nearly constant velocity model in the body reference frame.
	* ``INERTIAL_MEASUREMENT_UNIT``

TAU_P
-----
**Default:** 1000 

**Definition:** The bias in the standard navigation solution position has various different intensities and time constants associated with multipath, satellite clock modeling errors, satellite ephemeris errors, and ionospheric modeling errors.  We eliminate some of these with a turn-on-bias removal.  The remainder we try to capture with a single Gauss-Markov bias model. We make the time constant long so that the bias estimate reverts only slowly to zero after a loss of the precise positioning solution. Standard navigation solution position bias time constant, in seconds. Only relevant to POSE_AND_TWIST_18.

SIGMA_P_STANDARD
----------------
**Default:** 1

**Definition:** Standard navigation solution position bias steady-state standard deviation, in meters Only relevant to POSE_AND_TWIST_18.

POS_ALT1_ANTENNA_B, POS_ALT2_ANTENNA_B
--------------------------------------
**Default:** @HHH

**Definition:** Position of the ALT1 and ALT2 antennas' L1 phase centers in meters in body coordinates (note that the position of the primary antenna's L1 phase center in body coordinates is (0;0;0)). Only relevant to POSE_AND_TWIST estimators. Initialize to nan to force user to input these before use

SIGMA_CONSTRAINED_BASELINE_ERROR_RAD
------------------------------------
**Default:** 0.1

**Definition:** The standard deviation of the angular error in the constrained baseline vector, in radians.  This is a parameter in the QUEST formulation of the error covariance model for the unit vector correponding to the constrained baseline. This default is appropriate for short-baseline setups such as quads or VR array. Only relevant to POSE_AND_TWIST estimators.

AZIMUTH_ONLY_FROM_CONSTRAINED_BASELINE
--------------------------------------
**Default:** True

**Definition:** Only exploit the azimuth angle from the constrained baseline vector. The standard deviation of the azimuth angle will continue to be :ref:`SIGMA_CONSTRAINED_BASELINE_ERROR_RAD`. Only relevant to POSE_AND_TWIST estimators.

ESTIMATOR_TYPE
--------------
**Default:** POSE_AND_TWIST_15

**Definition:** Indicates the type of sigma-point estimator that will be applied. Select from the following options:

*PPose Estimators*

	* ``POSE_AND_TWIST_15``
	* ``POSE_AND_TWIST_18``
	* ``POSE_AND_TWIST_27``
	* ``POSE_AND_TWIST_15_VISION`` 
	* ``POSE_AND_TWIST_15_MULTI_MODEL``

*Position-only estimator*

	* ``POSITION_RTK``

*Constrained-baseline estimator*

	* ``ATTITUDE_2D`` 

INCLUDE_STANDARD_NAVIGATION_SOLUTION_VELOCITY_MEASUREMENT
----------------------------------------------
**Default:** False

**Definition:** Indicates whether the standard navigation solution velocity measurement should be included in the estimator

PRECISE_POS_MEASUREMENT_SIGMA_INFLATION_FACTOR
----------------------------------------------
**Default:** 3

**Definition:** Inflation factor by which the precise position measurement error standard deviation is inflated to compensate for its being optimistic due to neglect of multipath errors. Only relevant to POSE_AND_TWIST estimators when consuming SBRTK and A2D reports.

OUTPUT_EVENT
------------
**Default:** MEASUREMENT_UPDATE

**Definition:** The event that triggers output of the estimator's solution. Only relevant to POSE_AND_TWIST estimators. POSITION_RTK and ATTITUDE_2D output on every rover epoch. Select from the following options:

* ``TIME_UPDATE``
* ``MEASUREMENT_UPDATE``

Note that we don't allow output at both time and measurement updates to avoid updates with different solutions but marked at the same time.

INTEGRATOR_TYPE
---------------
**Default:** EULER_METHOD

**Definition:** Which type of dynamics integration to use. Only relevant to POSE_AND_TWIST estimators. Select from the following options:

* ``EULER_METHOD``
* ``PIECEWISE_CONSTANT_AW_OMEGAB``

SPF_NUM_THREADS
---------------
**Default:** @HHH

**Definition:** Sets the number of threads SPF is allowed to use for sigma point evaluation.

APPLY_VEHICLE_VELOCITY_CONSTRAINTS
----------------------------------
**Default:** False

**Definition:** Indicates whether to apply vehicle near-zero-sideslip and near-zero-vertical velocity constraints. See documentation in :download:`estimation of vehicle frame extrinsics <./../../../src/velocity_frame_extrinsics_estimation_for_ground_vehicle_todd.pdf>`.. Also see :download:`this matlab script <./../../../src/estimateVehicleFrameExtrinsics.m>`. Only relevant to POSE_AND_TWIST estimators.

ORIENTATION_B2V
---------------
**Default:** @HHH

**Definition:** Orientation of the body (B) frame relative to the vehicle (V) frame, expressed as a quaternion.  The quaternion should be formed such that RVB = navtbx:quat2dc(ORIENTATION_B2V) is the direction cosine matrix that translates a vector expressed in the B frame to one expressed in the V frame: vV = RVB*vB. Only relevant to POSE_AND_TWIST estimators.

POS_V0_B
--------
**Default:** @HHH

**Definition:** Position of the vehicle center of rotation V0 (which is also the vehicle frame origin) in meters in body coordinates. Only relevant to POSE_AND_TWIST estimators.

SIGMA_VEHICLE_VELOCITY_CONSTRAINT_MPS
-------------------------------------
**Default:** 0.2 0.3

**Definition:** The standard deviations of the near-zero vehicle velocity constraints in the vehicle Y and Z directions, in meters per second. Only relevant to POSE_AND_TWIST estimators.

POLYNOMIAL_COEFFICIENTS_OMEGABZ_TO_V0VY
---------------------------------------
**Default:** 0 0

**Definition:** Polynomial coefficients relating the angular rate in the body Z direction and vVy, the y-component of the vehicle velocity with respect to W and expressed in V: vVy = P(0) + P(1)*omegaBz + P(2)*omegaBz^2 + ..., where [P(0) P(1) ... P(N)] is the ordering from the config file. Beware that this coefficient order convention is opposite Matlab's. Only relevant to POSE_AND_TWIST estimators.

APPLY_ZERO_VELOCITY_CONSTRAINT
------------------------------
**Default:** False

**Definition:** Indicates whether to apply a zero-velocity constraint triggered by the inertial sensor. Only relevant to POSE_AND_TWIST estimators.

SIGMA_ZERO_TRANSLATIONAL_VELOCITY_CONSTRAINT_MPS
------------------------------------------------
**Default:** 0.02

**Definition:** The standard deviation of the zero translational velocity constraint triggered by the inertial sensor, in meters per second.  This sigma applies to the vehicle Y and Z directions; the sigma in the vehicle X (forward) direction is scaled up internally to account for the greater uncertainty in the X direction (e.g., due to a slow vehicle roll). Only relevant to POSE_AND_TWIST estimators.

SIGMA_ZERO_ROTATIONAL_VELOCITY_CONSTRAINT_RPS
---------------------------------------------
**Default:** 0.002

**Definition:** The standard deviation of the zero rotational velocity constraint triggered by the inertial sensor, in radians per second. This sigma applies equivalently to the IMU (U) roll, pitch, and yaw directions. Only relevant to POSE_AND_TWIST estimators.

INNOVATIONS_TEST_PF
-------------------
**Default:** 1e-6

**Definition:** Innovations testing within SigmaPointFilter is based on the normalized innovations squared (NIS) statistic, NIS = dot(dzn, dzn), which under a consistent estimator is chi-square distributed with zr.n_elem degrees of freedom.  A constant false-alarm rate test is performed using an NIS with a false-alarm probability of INNOVATIONS_TEST_PF (see chisquaredtest.h/cpp in gss). Only relevant to POSE_AND_TWIST estimators. GNSS-related innovations testing is configured in CdgnssConfig.

PERFORM_INNOVATIONS_TESTING
---------------------------
**Default:** True

**Definition:** When false, innovations testing using INNOVATIONS_TEST_PF is not performed.

BACKWARD
--------
**Default:** False

**Definition:** When true, the estimator is configured to run backward in time. Setting this parameter to true merely configures the estimator to expect and operate on a time-reversed data stream. It does not cause a normal data stream to be reversed.

CONSUME_EXTERNAL_CDGNSS_REPORTS
-------------------------------
**Default:** True

**Definition:** When true, measurement updates are performed with incoming SingleBaselineRtk and Attitude2D GBX reports. Otherwise, SingleBaselineRtk and Attitude2D GBX reports are only used for filter initialization

ZERO_VELOCITY_UPDATE_DF_MAGNITUDE_THRESHOLD
-------------------------------------------
**Default:** 0.8

**Definition:** Accelerometer and gyro thresholds used to detect vehicle stationarity for zero-velocity updates. The vehicle is considered stationary when the vector norms of deltas between the two most recent accelerometer (DF) and gyroscope (DOMEGATILDE) measurements are both below these thresholds for at least ZERO_VELOCITY_UPDATE_CONSECUTIVE_COUNT_THRESHOLD IMU measurements. Only relevant to POSE_AND_TWIST estimators.

ZERO_VELOCITY_UPDATE_DOMEGATILDE_MAGNITUDE_THRESHOLD
----------------------------------------------------
**Default:** 0.006

**Definition:** Accelerometer and gyro thresholds used to detect vehicle stationarity for zero-velocity updates. The vehicle is considered stationary when the vector norms of deltas between the two most recent accelerometer (DF) and gyroscope (DOMEGATILDE) measurements are both below these thresholds for at least ZERO_VELOCITY_UPDATE_CONSECUTIVE_COUNT_THRESHOLD IMU measurements. Only relevant to POSE_AND_TWIST estimators.

ZERO_VELOCITY_UPDATE_CONSECUTIVE_COUNT_THRESHOLD
------------------------------------------------
**Default:** 10

**Definition:** Accelerometer and gyro thresholds used to detect vehicle stationarity for zero-velocity updates. The vehicle is considered stationary when the vector norms of deltas between the two most recent accelerometer (DF) and gyroscope (DOMEGATILDE) measurements are both below these thresholds for at least ZERO_VELOCITY_UPDATE_CONSECUTIVE_COUNT_THRESHOLD IMU measurements. Only relevant to POSE_AND_TWIST estimators.