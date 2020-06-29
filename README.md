# MonoWp_ATLAS

Author: K.Yoon

## Overview

## Setup environment variables
**Always** run `config.sh` in bash before using this suite. You may customize the environment variables according to your needs by editing the script. Respect the warnings!

## Modules
### Fast Simulation

### Statistics
* `Analysis/src/StandardHypoTestInvDemo.C` | I modified it to write to a root file.

### Plotting
* `Analysis/scripts/visualization/brazilplot.py` | Plot upper limits as a band with median and +/- 1 and 2 sigmas.
* `Analysis/scripts/visualization/signal_efficiency.py` | Plot signal efficiency as a function of m<sub>W'</sub>.

### Selection Parameters
Selection parameters are referred to with a string key (e.g. lincut1, lincut2, ttonly, etc.) which corresponds to a Python dict() object. The module which reads and writes the Python dict() objects is `Cuts.py`.

Comprehensive list of selection parameters. (Units are in GeV)
* 'lincut1'
  * Linear cut on invariant masses or related kinematic variables
  * W mass window: \[m<sub>W</sub> + 20, m<sub>W</sub> - 20\]
  * t mass window: \[m<sub>t</sub> + 40, m<sub>t</sub> - 40\]
  * Missing energy lower limit: 200

## Directory tree
Here is the directory tree.
