.. _ppengine:
=====================================
Precise Positioning Engine (ppengine)
=====================================

This page describes how to configure, run, and interpret output from ppengine, which is an implementation of GRID, the General Radionavigation Interfusion Device.

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

 To run an example
