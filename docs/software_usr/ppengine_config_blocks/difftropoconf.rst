.. _difftropoconf:
==========
DIFF_TROPO 
==========
The DIFF_TROPO bank consists of the following configurations:

MODEL_TYPE
----------
**Default:** SAASTAMOINEN_NMF

**Definition:** Differential tropospheric delay model

	* ``SAASTAMOINEN_NMF``: Applies Saastamoinen zenith tropospheric delay models and Niell mapping functions, evaluated separately at the reference and rover positions. Configuration-provided, GBX-provided, or default surface weather conditions (temperature, pressure, humidity) apply for the reference station and are extrapolated to the rover station following page 3 of http://gauss2.gge.unb.ca/papers.pdf/ion52am.collins.pdf.
	* ``GBAS_MCGRAW``: An implementation of the GBAS/LAAS differential tropopsheric delay model described in https://www.ion.org/publications/abstract.cfm?articleID=5959. This model was derived by applying simplifying assumptions (1/sin mapping function, equal SV elevation angle at reference and rover, etc.) to what is essentially the Saastamoinen model. This model probably does not offer any benefit beyond ``SAASTAMOINEN_NMF``.
	* ``ONE_STATE_RESIDUAL_REL_ZTD_SAASTAMOINEN_NMF``: SAASTAMOINEN_NMF plus a single additional "residual relative zenith tropospheric delay" state added to the filter state vector. This additional state is modeled as a zero-mean OU process and is an additional bias added to the delta ZTD predicted by the Saastamoinen model. The online residual delay estimation only seems to be helpful when vertical separation between the reference and rover is on the order of 1 km or greater. Only PositionRtk can use this model.
	* ``ONE_STATE_RESIDUAL_REL_ZTD_NONE`` NONE plus the same additional filter state as described above.  In this case, the filter state is the total delta zenith tropospheric delay between the reference and rover.
	* ``ONE_STATE_RESIDUAL_REL_ZTD_GBAS_MCGRAW``: GBAS_MCGRAW plus the same additional filter state as described above.
	* ``NONE``

STEADY_STATE_DZTD_UNCERTAINTY
-----------------------------
**Default:** 0.05

**Definition:** Steady-state uncertainty (in meters) for the Ornstein-Uhlenbeck (OU) process describing the differential zenith tropo delay in the "stateful" differential tropospheric delay mdoels (currently ``ONE_STATE_RESIDUAL_REL_ZTD_``*).

DZTD_TIME_CONSTANT
------------------
**Default:** 60

**Definition:** Time constant (in seconds) of the aforementioned differential ZTD OU process.

DEFAULT_AMBIENT_PRESSURE
------------------------
**Default:** 101325

**Definition:** Default surface weather measurements used by models in the absence of configuration file parameters or incoming AtmosphericParameters GBX messages. These surface weather parameters are assumed to apply at the reference station, and in some models are extrapolated to calculate approximate atmospheric conditions at the rover. Ambient pressure, in Pascals

DEFAULT_AMBIENT_TEMPERATURE
---------------------------
**Default:** 294.261111

**Definition:** Ambient temperature, in Kelvin

DEFAULT_RELATIVE_HUMIDITY_PCT
-----------------------------
**Default:** 60

**Definition:** Relative humidtiy, expressed as a percentage (0-100)

