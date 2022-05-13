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

The default configuration files described above are for a rover receiver connected to a reference network.  To be able to use these as provided, set up a local reference station running pprx and refnet_server. Ensure that the reference station's IP address is accessible to the rover computer. Put the reference station's IP address in pprx's options file; e.g., ``~git/gss_top/run/pprx.opt``:

.. code-block:: bash

	--ref-host=10.0.0.2    # <---- Put the reference station's IP address here


To ensure the reference station is connected to the rover receiver: 

	* ``refnet_monitor`` is a simple utility that allows one to connect to and monitor GBX traffic received from a reference server. ``refnet_monitor --help`` offers rather straight-forward command-line options. When done, kill it using Ctrl-C. Example usage:

		.. code-block:: bash

			refnet_monitor --hostname 10.0.0.2

Instructions on how run the rover receiver with reference station:

#. Run ``refnet_monitor`` to check that the reference receiver is working and the network connection is good:

	.. code-block:: bash

		refnet_monitor --hostname 10.0.0.2

#. Create pipes for realtime operation:

	.. code-block:: bash

		cd ~/git/gss_top/scripts
		./make_pipes

#. Run the Python startup script:   

	.. code-block:: bash

		cd ~/git/gss_top/scripts
		./stack.py

#. tmux window 2 will show the progress of PpEngine as it processes signals tracked by pprx.  

#. After 30 seconds, pprx will be stably tracking several satellites.  At this point, PpEngine will attemp to obtain a precise Attitude 2D fix, a Single Baseline RTK fix, or both, depending on how ppengine.opt is configured.  If there are enough satellites with clean enough measurements, the indicator 'fixed' will appear.  If PpEngine fails to obtain a fix, see below for troubleshooting.

#. If PpEngine has been configured in ppengine.opt to produce a Pose solution, it will display this solution at the bottom of the text display.  This solution gives the East-North-Up (ENU) coordinates of the primary snapon-antenna-assembly antenna relative to the reference antenna, and the pitch, roll, and yaw (3-1-2 Euler rotation) angles that define the antenna assembly's attitude relative to the local ENU frame.  

#. To quit, go to the tmux window where PpEngine is running (tmux window 2), hit ''Ctrl-C'', and then type ''tkill'' at the prompt.