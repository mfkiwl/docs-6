.. _operational_modes:
=================
Operational Modes
=================

Receiver Autonomous Operation
-----------------------------

Receiver Autonomous Operation is defined as when the GNSS receiver **is not** connected to a reference station. Refer to the Sofware User Guide on pprx to set up the receiver for autonomous operation.


Carrier-Phase Differential (RTK) Operation
------------------------------------------

Carrier-Phase Differential (RTK) Operation is defined as when the GNSS receiver **is** connected to a reference station via wifi. Refer to the Sofware User Guide on pprx and ppengine to set up the rover receiver. 

To ensure the reference station is connected to the rover receiver: 

	* ``refnet_monitor`` is a simple utility that allows one to connect to and monitor GBX traffic received from a reference server. ``refnet_monitor --help`` offers rather straight-forward command-line options. When done, kill it using Ctrl-C. Example usage:

		.. code-block:: bash

			refnet_monitor --hostname 10.0.0.2
