# MobZ: Driving Past Commuting Zones: Re-examining Local Labor Market Definitions



[![DOI](https://zenodo.org/badge/72544899.svg)](https://zenodo.org/badge/latestdoi/72544899)



Authors: Andrew Foote, Mark Kutzbach, [Lars Vilhuber](https://github.com/larsvilhuber)

The repository has the following structure:

- [raw](raw/): Location for raw (unprocessed) datasets. We do not provide the data, but provide the download locations. The datasize may be substantial.
- [data](data/): Location for transformed datasets. Some of the transformations may have been manual, and are documented in the [README](data/README.md) in that directory
- [programs](programs/): Programs to read in raw data, process the data, and create the analysis are here. Programs may be in SAS or Stata.

The relevant Paper is on Overleaf and in a separate Github repo.
 - Overleaf at https://www.overleaf.com/2317154671nnzkcxzjftbq (owned by Andrew)
 - synced to https://github.com/larsvilhuber/Recalculating-new-version-

## Submodule stuff
In this repo, the paper repo is a `git submodule` in the directory `paper`. 

### Creating it

The submodule was created as

    git submodule add git@github.com:larsvilhuber/Recalculating-new-version-.git paper

### Cloning the repo, initializing the submodule

Method 1:

    git clone --recurse-submodules (REPO URL)

Method 2: Clone as usual, then

    git submodule init
    git submodule update 

## Computing

I have a clone of the MobZ repo on ECCO: ecco:/ssgprojects/project0002/MobZ. 