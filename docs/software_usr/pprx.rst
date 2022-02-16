.. _pprx:

Precise Positioning Receiver (pprx)
===================================

This page describes how to set up, compile, configure, run, and interpret output from pprx, which is an implementation of GRID, the General Radionavigation Interfusion Device.

Editing Options Files
---------------------

pprx is highly configurable via both command-line options and configuration parameters. Type ``pprx --help`` to see a list of command-line options. These options are specified in a ``.opt`` file as seen in the example below:

Editing Configuration Parameters
--------------------------------
pprx configuration files are broken into configuration blocks. The start of each block is indicated by a block header, e.g., ``ESTIMATOR``. An example configuration file can be found here:


To edit the configuration parameters in the ``.config`` file, see the below blocks:

.. toctree::
   :maxdepth: 4

   pprx_config_blocks/frontend
   pprx_config_blocks/bank
   pprx_config_blocks/bufferloader
   pprx_config_blocks/estimator

How to Run
----------

 To run an example
