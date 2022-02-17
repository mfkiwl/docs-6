.. _binflate:
========
Binflate
========
GRID/pprx natively outputs data in the GRID Binary Exchange (GBX) format. Use the binflate utility to interactively view the data (``-x`` or ``-p``), or convert them to ASCII log files (``-s log``), Matlab .mat files (``-s mat``), a Rinex 2.11 observables file (``-s rin``), or a Google Earth KML file (``-s kml``). 

Have a look at the various binflate options by typing
.. code-block:: bash
   :linenos:

   binflate --help

To view GBX data in interactive mode, use the ``-x`` option:
.. code-block:: bash
   :linenos:

	binflate -i some_gbx_file.gbx -x

While in interactive mode, you can type ``h`` at the prompt to see a list of options.

To view select GBX reports graphically while in interactive mode, binflate requires gnuplot, which you can install as follows:
.. code-block:: bash
   :linenos:

   sudo apt install gnuplot

Then use the ``-p`` option: 
.. code-block:: bash
   :linenos:

	binflate -i some_gbx_file.gbx -p

To create several ASCII log files described column-by-column in the documents @hailey LINK TO LOG FILE DEFS, call binflate like this:
.. code-block:: bash
   :linenos:

	binflate -i some_gbx_file.gbx -s log

For example, the format of channel.log is documented @hailey LINK TO CHANNEL DEF. 

If you'd rather inflate the GBX files to binary Matlab .mat files for easy loading into Matlab, call binflate like this:
.. code-block:: bash
   :linenos:

	binflate -i some_gbx_file.gbx -s mat
 
You can draw the .mat files into Matlab as follows:
.. code-block:: matlab
   :linenos:

	load channel.mat;
	channel = channel'; % Transpose to put in columnar format

The format of the matrices that get loaded into Matlab is the same as that of the ASCII files.

Likewise, the -s rin and -s kml options inflate to Rinex 2.11 `format <https://gage.upc.edu/sites/default/files/gLAB/HTML/Observation_Rinex_v2.11.html>`_ and Google Earth KML `format <https://developers.google.com/kml/documentation/>`_. By default, binflate inflates GBX files into Matlab .mat files.