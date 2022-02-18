.. _pprxdisplay:
=======
DISPLAY
=======
The display bank consists of the following configurations:

.. image:: ./../../images/liondisplay.png
   :width: 60 %
   :align: center

USE_COLOR
-----------
Default = true. Color the display to stdout

MESSAGE_PRINTING_PERSISTENCE
----------------------------
Default = 5. Number of consecutive displays to print a given status message
 
DISPLAY_EXTRA_FIELDS
--------------------
Default = false. Print extra information like phase lock statistics

MAXIMUM_BANK_COLUMNS
--------------------
Default = 2. Maximum number of columns for Bank displays

WRAP_BANK_ROWS
--------------
Default = false. When true, Banks that would exceed :ref:`MAXIMUM_BANK_COLUMNS` are wrapped to the next row. When false, those Banks are not displayed.

MIX_BANK_ROWS
-------------
Default = false. MIX_BANK_ROWS determines whether different GenericTypes can be displayed in the same row. This setting is only meaningful when WRAP_COLUMNS is true.

REDRAW_PERIOD
-------------
Default = 1. Display data are printed every REDRAW_PERIOD log intervals