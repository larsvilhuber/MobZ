## Software Requirements


- SAS 9.4 (TS1M0) 
  - SAS/STAT 12.3 (maintenance)
- Stata 14.2
- R 4.0.2 (used only to automate cleaning of one data file)
  - readxl, tidyr, dplyr, readr for processing
  - rprojroot, config for configuration
  - all dependencies are installed upon first run
- Bash, Curl, wget as part of download (may require Linux, but can be replaced by manual downloading)


## Memory and Runtime Requirements

These programs were last run as follows:

- OS: Linux CentOS release 6.3 (Final)
- 8-core (though probably only 1 core was in use)
- 147 GB RAM (unlikely to have been fully utilized)
- about 1.5GB disk space required 

## Description of programs

### Setting up data

See the [raw data README.md](../raw/README.md) for details in preparing the raw data files. They are not downloaded by the SAS and Stata programs in the `$programs` folder.

### Main program files

```{r list_programs1,include=TRUE}
bind_rows(enframe(list.files(programs,recursive=FALSE,full.names=FALSE,
                   pattern="*.do")),
          enframe(list.files(programs,recursive=FALSE,full.names=FALSE,
                   pattern="*.sas"))) %>%
    arrange(value) %>%
    select(filename=value) %>% 
  kable()
```

### Setting up programs

- modify `config.sas`: 
  - change the line with root to correspond to your project directory
- modify `config.do`:
  - change the line with root to correspond to your project directory

### Order of programs to run

To create the replicated commuting zones,
run the following programs (parameters below):

#### Reading in various datasets


```
sas 01_dataprep.sas
```
*(runtime: 2.81s)*

#### CLUSTERING PROCESS

```
sas 02_cluster.sas
```
*(runtime: 3:25.73 minutes)*

OUTPUT: $data/clusfin_jtw1990.sas7bdat


#### CUTOFF by CLUSTER COUNT GRAPH

```
sas 03_prep_figures.sas
stata -b do 04_figures2_3.do
```
The first program took 8:50 minutes. 
The second one runs in seconds.


### BOOTSTRAP


#### Run the Bootstrap

Projects MOEs from 2009-2013 onto 1990 data,	creates the 1000 realizations of commuting zones.

```
stata -b do 05_01_flows.do
sas         05_02_bootstrap.sas
```
The first program runs in seconds, the second one takes 55 hours.

#### Figure 4

```
stata -b do 05_03_bootstrap_graphs_new.do 
```
*(runtime: seconds)*

	
### Replication programs for analysis in Section 4.1 


All programs are in `$programs/06_qcew/` subdirectory. Change working directory.

```{r list_programs2,include=TRUE}
bind_rows(enframe(list.files(file.path(programs,"06_qcew"),recursive=FALSE,full.names=FALSE,
                   pattern="*.do")),
          enframe(list.files(file.path(programs,"06_qcew"),recursive=FALSE,full.names=FALSE,
                   pattern="*.sas"))) %>%
    arrange(value) %>%
    select(filename=value) %>% 
  kable()
```

(NOT ADJUSTED YET)

Data prep programs:

- 00.bea_readin.do
- 00.qcew_extraction.sas

Regression table:

- 01_regressions_table.do

Graphs:

- Figure 5:
  - 02.01.cluster_loop.do
  - 03.01.cluster_graphs.do

- Figure 6:
  - 02.02.cutoff_loop.do
  - 03.02.cutoff_graphs.do (creates figure 6)

Programs called during processing: zz_bartik_merge.do

### Replication programs for Section 4.2

All programs  in `$programs/adh/` subdirectory

Data prep programs (in order):

- 00.01.IPW_creation.do
- 00.02.mergecounty.do
- 00.03.cz_merge.do
- 00.04.aggregatedata.do

Table 3 is created by:

-  01.table3.do

Figures are created by:

- Figure 7:
  - 02.02.overall_loop.do
  - 03.02.overall_graphs.do 
- Figure 8
  - 02.01.cutoff_loop.do
  - 03.01.cutoff_graphs.do 



## List of tables and programs

(needs to read in code-check.xlsx)