.. _imuconf:
===
IMU 
===
Below is an *example* of the IMU block: 

.. literalinclude:: ./../../../src/runtime_files/ppose.config
    :lines: 22-29

The IMU block contains all of the following configuration parameters:

IMU_TYPE
--------
**Default:** AUTOMOTIVE

**Definition:** Assumed relative vector dynamics model, used by PositionRtk and Attitude2D estimators. (PoseAndTwist estimators require an IMU). Select from the following options:

	* ``AUTOMOTIVE``
	* ``INDUSTRIAL``
	* ``TACTICAL_LOW_QUALITY``
	* ``TACTICAL_HIGH_QUALITY`` 
	* ``NAVIGATION``
	* ``CUSTOM1``
	* ``CUSTOM2``
	* ``CUSTOM3``
	* ``CUSTOM``
	* ``LORD``
	* ``TASNAL``

POS_IMU_B
---------
**Default:** [0 0 0]

**Definition:** Position of the IMU's accelerometer triad in meters in body coordinates

ORIENTATION_IMU_B
-----------------
**Default:** [0 0 0 1]

**Definition:** Orientation of the IMU frame relative to the body frame, expressed as a quaternion.  The quaternion should be formed such that ``RBU = navtbx:quat2dc(ORIENTATION_IMU_B_)`` is the direction cosine matrix that translates a vector written in the IMU frame U to one written in B: vB = RBU*vU.

ACCELEROMETER_BIAS_U
--------------------
**Default:** [0 0 0]

**Definition:** Static bias of the accelerometer, in m/sec^2 in the U frame.

ACCELEROMETER_SCALE_FACTORS_U
-----------------------------
**Default:** [1 1 1]

**Definition:** Accelerometer scale factors along the X, Y, and Z axes in the U frame

GYRO_BIAS_U
-----------
**Default:** [0 0 0]

**Definition:** Static bias of rate gyros, in rad/s in the U frame


GYRO_SCALE_FACTORS_U
--------------------
**Default:** [1 1 1]

**Definition:** Gyro scale factors along the X, Y, and Z axes in the U frame

SENSOR_ID
---------
**Default:** 0

**Definition:** Identifies which IMU out of multiple possible