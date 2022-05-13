.. _bufferloader:
=============
BUFFER_LOADER
=============
The buffer-loader bank consists of the following configurations:

.. image:: ./../../images/lionbufferloader.png
   :width: 60 %
   :align: center


NUM_BUFFER_LOADERS
------------------
**Default:** N/A. Required input. For RadioLion this should be set to 1.

**Definition:** How many buffer loaders you have. One RadioLion = 1 Buffer Loader.

BL01
----
**Default:** N/A. Required input.

**Definition:** ``BL_LION`` corresponds to buffer loader 1, with device LION.

DEVICE
------
**Default:** N/A. Required input.

**Definition:** ``LION`` corresponds to the device name.

TYPE
----
**Default:** N/A. Required input.

**Definition:** Operational modes. Select from the following options:

* ``FILE``: Post-process capture files
* ``USB``: Support live capture operations

FRONT_ENDS
----------
**Default:** N/A. Required input.

**Definition:** ``LION LION_L5`` corresponds to the RadioLion.