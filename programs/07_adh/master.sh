stata -b do 00_01_census_creation.do
stata -b do 00_02_ctyindustry_creation.do
stata -b do 00_03_IPW_creation.do
stata -b do 00_04_cbp_readin.do
stata -b do 00_05_subset_qcewdata.do
stata -b do 00_06_mergecounty.do
stata -b do 00_07_cz_merge.do
stata -b do 01_table3.do
stata -b do 02_01_cutoff_loop.do
stata -b do 02_02_overall_loop.do
stata -b do 03_01_cutoff_graphs.do
stata -b do 03_02_overall_graphs.do