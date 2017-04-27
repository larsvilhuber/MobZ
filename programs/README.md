To replicate results in paper
===============================


Order of programs to run
=========================

To create the replicated commuting zones,
run following programs (parameters below):

00.dataprep/module_prepjtw1990.sas
	No parameters

00.dataprep/module_geoaggjtw1990.sas
	dset: jtw1990 ;
	

10.cluster/module_clustjtw1990.sas

10.cluster/module_reviewjtw1990.sas

OUTPUT: root/data/clusfin_jtw1990.sas7bdat

==========================================

MODULE BOOTSTRAP
==========================================

./programs/flows.do
	Projects MOEs from 2009-2013 onto 1990 data
	NOTE: MUST RUN module_prepjtw1990.sas first (inputs created there)

20.analysis/module_bootstrap.sas
	creates the 1000 realizations of commuting zones 
	and figures for paper
	Also creates inputs for appendix table

==========================================
CUTOFF by CLUSTER COUNT GRAPH
==========================================
20.analysis/module_cutoff.sas
	Creates a graph called numclus_cutoff.png

===========================================
Replication programs for ADH
===========================================
Table 1 is created by:
      - ./replication/comparison_regressions.do

Figures are created by:
       - ./replication/iteration/overall_loop.do
       - ./replication/iteration/overall_graphs.do

       - ./replication/iteration/cutoff_loop.do
       - ./replication/iteration/cutoff_graphs.do

