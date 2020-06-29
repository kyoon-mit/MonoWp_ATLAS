#!/usr/bin/env bash

# WARNING: DO NOT MOVE THIS FILE. KEEP IT AT THE TOP-LEVEL DIRECTORY.


###### WARNING: DO NOT CHANGE THESE ENVIRONMENT VARIABLES ######

# Where this config file is stored. 
export DIRTOP_MONOWP=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# Top-level analysis directory
export DIRANALYSIS_MONOWP=${DIRTOP_MONOWP}/Analysis

# Top-level hist2workspace config files directory
export DIRCONFIG_MONOWP=${DIRANALYSIS_MONOWP}/config

################################################################



###### YOU MAY CHANGE THESE ENVIRONMENT VARIABLES ##############

# Where your simulation data files are stored.
export DIRDATA_MONOWP=${DIRTOP_MONOWP}/Data

################################################################
