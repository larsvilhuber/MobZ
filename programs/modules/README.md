MODULES IN THIS FOLDER
============================

Each of the modules listed includes separate steps to create the various outputs, organized into steps. All have a ctrl file, which runs the indicated modules.

STEP 0: 00.dataprep
====================
These modules read in the data used in all downstream processes

STEP 1: 10.cluster
====================
These modules perform the clustering methods, both hierarchical clustering (using the %cluster macro) and other methods. It also includes modules that take the tree created by hierarchical clustering and, given a cutoff, assign the zones (anything using the %review macro).

STEP 2: 20.analysis
====================
These modules perform downstream analysis, such as the bootstrap procedure, which resamples the commuting flows, graphing results, or calculating the objective function.

STEP 3: 25.postprocess
=====================
There are a number of modules in this step that check contiguity or divergence of different definitions. 

