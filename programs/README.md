To replicate results in paper
===============================

## Requirements

These programs were last run as follows:

- OS: Linux CentOS release 6.3 (Final)
- 8-core, 147 GB RAM, about 1.5GB disk space required
- SAS 9.4 (TS1M0) 
  - SAS/STAT 12.3 (maintenance)
- Stata 14.2



## Setting up programs


- modify `config.sas`: 
  - change the line with root to correspond to your project directory
- modify `config.do`:
  - change the line with root to correspond to your project directory

## Order of programs to run


To create the replicated commuting zones,
run following programs (parameters below):

### Reading in various datasets

See the [relevant README.md](../raw/README.md) for details in preparing the raw data files. They are not downloaded by the SAS programs here.

```{bash}
sas 01_dataprep.sas
```
(runtime: 2.81s)

### CLUSTERING PROCESS

```{bash}
sas 02_cluster.sas
```
(runtime: 3:25.73 minutes)

OUTPUT: root/data/clusfin_jtw1990.sas7bdat


### CUTOFF by CLUSTER COUNT GRAPH

```{bash}
sas 03_prep_figures.sas
sas 04_figures2_3.sas
```
The first program took 8:50 minutes.

20.analysis/module_cutoff.sas
20.analysis/module_graph.sas Creates the graphs which are Figure 2 and 3 in the paper

## BOOTSTRAP

- ./programs/02_flows.do
	Projects MOEs from 2009-2013 onto 1990 data
	NOTE: MUST RUN module_prepjtw1990.sas and module_prepjtw2009.sas first (inputs created there)

- ./modules/20.analysis/module_bootstrap.sas
	creates the 1000 realizations of commuting zones 

- /programs/statado/bootstrap_graphs_new.do
	creates Figure 4 in the paper.
	
Replication programs for Section 4.1 (in /qcew/ subdirectory)
=====================================
Creation programs:

	-00.bea_readin.do
	-00.qcew_extraction.sas

Regression table:

	- 01_regressions_table.do

Graphs:
	
	- 02.01.cluster_loop.do
	- 03.01.cluster_graphs.do (creates figure 5)
	
	- 02.02.cutoff_loop.do
	- 03.02.cutoff_graphs.do (creates figure 6)

Programs called during processing: zz_bartik_merge.do

Replication programs for ADH (Section 4.2) (in /adh/ subdirectory)
===========================================
Creation programs (in order):

	- 00.01.IPW_creation.do
	- 00.02.mergecounty.do
	- 00.03.cz_merge.do
	- 00.04.aggregatedata.do

Table 3 is created by:

	 - /01.table3.do

Figures are created by:
      
	 - /02.02.overall_loop.do
	 - /03.02.overall_graphs.do (creates figure 7)

	- /02.01.cutoff_loop.do
	- /03.01.cutoff_graphs.do (creates figure 8)

