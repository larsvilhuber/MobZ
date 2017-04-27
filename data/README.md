# Data directory
Transformed data goes here.

# bootclusters_jtw1990_moe.csv

This dataset is the 1000 realizations of the commuting zones from our paper. It can be used the crosswalk county fips codes to commuting zone realizations. The naming convention for the commuting zones in our data is CL + (fips of largest county by residence labor force), but otherwise are arbitrary. If the county is in a singleton, the name is "CL" + "10" + (fips)

# clusters_cutoff_jtw1990.csv

This dataset is a crosswalk from county to commuting zone, based on the cutoff used. The naming convention for the commuting zone definitions is clus[cutoff], where cutoff = 10000*(actual cutoff). For example, clus9190 provides commuting zone definitions if the cutoff value of the algorithm is 0.9190. The cluster naming convention is the same as above.