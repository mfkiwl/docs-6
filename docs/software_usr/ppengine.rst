.. _ppengine:
=====================================
Precise Positioning Engine (ppengine)
=====================================

This page describes how to configure, run, and interpret output from ppengine, which is an implementation of GRID, the General Radionavigation Interfusion Device.

Steps to Enable PPengine
------------------------

#. Determine if your system has (1) or (2) antennas capability. (2) is preferred if possible. Designate one as the primary antenna.  
#. Fix the location of the RadioLion with respect to the antennas.
#. Make measurement of the location of the RadioLion IMU with respect to the primary antenna. The RadioLion IMU is located in the red square in the following picture:

.. image:: ./../../images/RadioLiondraw.png
   :width: 60 %
   :align: center

The measurements needed are as follows:

#. In the ``a2d.config`` file, change the ``BASELINE_LENGTH_CONSTRAINT`` to the distance between the primary and secondary antenna. This measurement should be the positive X direction between antennas, measured in meters.

#. In the ``ppose.config`` file, change the ``ESTIMATOR_TYPE`` to ``POSE_AND_TWIST_27``. Change the ``POS_ALT1_ANTENNA_B`` to the location of the secondary antenna with respect to the first antenna in the body frame. This is a three coordinate vector (x, y, x), measured in meters. Please be as precise as possible. See the picture below for an example of this calculation on a quadcopter. 

.. image:: ./../../images/body_frame.png
   :width: 80 %
   :align: center

In the ``IMU`` Bank, there are numerous parameters that need to be filled out:
   * For ``IMU_TYPE``, set it to ``IMU_TYPE = CUSTOM2``.
   * ``POS_IMU_B`` is the position of the IMU in the body frame. This is a three coordinate vector (x, y, x), measured in meters. Please be as precise as possible. See the picture below for an example of this calculation on a quadcopter. 

.. image:: ./../../images/body_frame_wr_imu.png
   :width: 80 %
   :align: center

   * ``ORIENTATION_IMU_B`` is a quaternion (4 elements) that represents the rotational position of the IMU with respect to the body frame. See the picture below for an example of the IMU frame vs. the body frame. 

.. image:: ./../../images/imu_in_body_frame.png
   :width: 80 %
   :align: center

   *Optional:* If you have a properly formatted ``pprx.opt`` file, you can run pprx and in the display, note the raw specific force components (+X, -X, +Y, -Y, +Z, -Z) are printed out. Move the RadioLion's IMU to align with each axis and put the six raw specific force components in :download:`this matlab script <./../../src/accelCalibration.m>`. After running the script, the quaternion for the IMU should be printed out. 

   * To start ``ACCELEROMETER_BIAS_U = 0 0 0`` 
   * To start ``ACCELEROMETER_SCALE_FACTORS_U = 1 1 1`` 
   * To start ``GYRO_BIAS_U = 0 0 0``
   * To start ``GYRO_SCALE_FACTORS_U = 1 1 1`` 

#. Run the start-up script ``stack.py`` for a few minutes to obtain a good pprx and ppengine solution. Make sure ppengine is run with the ``-s mat`` option. Collect the scripts ``diagnostics.log`` and ``poseandtwist.mat`` and export them to Matlab.

#. Use the following two scripts: :download:`IMU calibration <./../../src/onlineIMUCalibration.m>` and :download:`pose and twist analysis <./../../src/poseandTwistAnal.m>`.

#. In the ``onlineIMUCalibration.m`` script, change the parameters ``ORIENTATION_IMU_B``, ``ACCELEROMETER_SCALE_FACTORS_U``, ``GYRO_SCALE_FACTORS_U``, and ``POS_IMU_B`` to what you have set in the previous few steps. Download :download:`this parser<./../../src/diagsplitppe.sh>` and place it in the same folder that you have placed the ``diagnostics.log`` file. Make sure the datadir variable points to where your files are located. The script should output new parameters for ``ORIENTATION_IMU_B``, ``ACCELEROMETER_SCALE_FACTORS_U``, ``GYRO_SCALE_FACTORS_U``. Take these new values and update the ``ppose.config`` file.

#. In the ``poseandTwistAnal.m`` script, set the current_accel_bias to the value of ``ACCELEROMETER_BIAS_U`` (which for the first time will be 0 0 0) and set the current_gyro_bias to the value of ``GYRO_BIAS_U`` (which for the first time will be 0 0 0). The script will output a few different variables, but notable the ``bgU_mean`` and ``baU_mean``. These are the new values for the biases. Take these values and ADD them to the previous biases (the first time this is run, the new means will just become the biases). These new values should be placed in the ``ppose.config`` file.

#. With the new values, run ppengine again and save the ``diagnostics.log`` and ``poseandtwist.mat`` files. Repeat these steps a few times or until the numbers converge and stop changing (about 3-4 times).

#. Once this process is done, go back to ``ppose.config`` file, change the ``ESTIMATOR_TYPE`` to ``POSE_AND_TWIST_18``. The IMU is calibrated and precise positioning mode is now functional. 


Editing Options Files
---------------------

ppengine is highly configurable via both command-line options and configuration parameters. Type ``ppengine --help`` to see a list of command-line options. These options are specified in a ``.opt`` file as seen in the example below:


Editing Configuration Parameters
--------------------------------
pprx configuration files are broken into configuration blocks. The start of each block is indicated by a block header, e.g., ``ESTIMATOR``. An example configuration file can be found here:

To edit the configuration parameters in the ``.config`` file, see the below blocks:

.. toctree::
   :maxdepth: 1

   ppengine_config_blocks/cdgnssconf
   ppengine_config_blocks/baselineconf
   ppengine_config_blocks/estimatorconf

How to Run
----------

**Examining ``--help`` Documentation**
Running the following command
``ppengine --help``
will show all the command-line options available for pprx, including a brief description of each.  

**Running pprx**
Suppose ``ppengine.opt`` is a properly-formatted ppengine options file as described :ref:`Editing Options Files`. Navigate to the directory where this file is located and type ``ppengine -f ppengine.opt`` into the terminal window.
