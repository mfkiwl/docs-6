.. _pprxdisplay:
=======
DISPLAY
=======
Below is an *example* of the DISPLAY block: 

.. image:: ./../../images/liondisplay.png
   :width: 60 %
   :align: center

The DISPLAY block contains all of the following configuration parameters:

USE_COLOR
-----------
**Default:** True

**Definition:** Color the display to stdout

MESSAGE_PRINTING_PERSISTENCE
----------------------------
**Default:** 5

**Definition:** Number of consecutive displays to print a given status message
 
DISPLAY_EXTRA_FIELDS
--------------------
**Default:** False

**Definition:** Print extra information like phase lock statistics

MAXIMUM_BANK_COLUMNS
--------------------
**Default:** 2

**Definition:** Maximum number of columns for Bank displays

WRAP_BANK_ROWS
--------------
**Default:** False

**Definition:** When true, Banks that would exceed :ref:`MAXIMUM_BANK_COLUMNS` are wrapped to the next row. When false, those Banks are not displayed.

MIX_BANK_ROWS
-------------
**Default:** False

**Definition:** MIX_BANK_ROWS determines whether different GenericTypes can be displayed in the same row. This setting is only meaningful when WRAP_COLUMNS is true.

REDRAW_PERIOD
-------------
**Default:** 1

**Definition:** Display data are printed every REDRAW_PERIOD log intervals