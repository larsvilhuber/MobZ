To replicate results in paper
===============================

Setting up programs
===================

- modify `config.sas`: 
  - change the line with root to correspond to your project directory
- modify `config.do`:
  - change the line with root to correspond to your project directory

Order of programs to run
=========================

To create the replicated commuting zones,
run following programs (parameters below):

- 00.dataprep/module_prepjtw1990.sas
	No parameters
	
- 00.dataprep/module_prepjtw2009.sas
	No parameters needed

- 00.dataprep/module_geoaggjtw1990.sas
	dset: jtw1990 ;
	
- 00.dataprep/module_geoaggjtw2009.sas
	dset: jtw2009 ;

CLUSTERING PROCESS

- 10.cluster/module_clustjtw1990.sas

- 10.cluster/module_reviewjtw1990.sas
	This module generates the maps for Figure 1 in paper

OUTPUT: root/data/clusfin_jtw1990.sas7bdat


MODULE BOOTSTRAP
==========================================

./programs/02_flows.do
	Projects MOEs from 2009-2013 onto 1990 data
	NOTE: MUST RUN module_prepjtw1990.sas and module_prepjtw2009.sas first (inputs created there)

20.analysis/module_bootstrap.sas
	creates the 1000 realizations of commuting zones 
	and figures for paper
	Also creates inputs for appendix table

CUTOFF by CLUSTER COUNT GRAPH
==========================================
20.analysis/module_cutoff.sas
	20.analysis/module_graph.sas Creates the graphs which are Figure 2 and 3 in the paper

Replication programs for Section 4.1 (in /qcew/ subdirectory)
=====================================
Creation programs:

	-00.bea_readin.do
	-00.qcew_extraction.sas

Regression table:

	- 01_regressions_table.do

Graphs:
	
	- 02.01.cluster_loop.do
	- 03.01.cluster_graphs.do
	
	- 02.02.cutoff_loop.do
	- 03.02.cutoff_graphs.do

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
	 - /03.02.overall_graphs.do

	- /02.01.cutoff_loop.do
	- /03.01.cutoff_graphs.do

