# MobZ: Driving Past Commuting Zones: Re-examining Local Labor Market Definitions



[![DOI](https://zenodo.org/badge/72544899.svg)](https://zenodo.org/badge/latestdoi/72544899)



Authors: Andrew Foote, Mark Kutzbach, [Lars Vilhuber](https://github.com/larsvilhuber)

The repository has the following structure:

- [raw](raw/): Location for raw (unprocessed) datasets. We do not provide the data, but provide the download locations. The datasize may be substantial.
- [data](data/): Location for transformed datasets. Some of the transformations may have been manual, and are documented in the [README](data/README.md) in that directory
- [programs](programs/): Programs to read in raw data, process the data, and create the analysis are here. Programs may be in SAS or Stata.
- [replication](replication/): as part of the paper, we replicate Autor, Dorn, Hanson (2013). The code to do that is in this directory.
- [paper](paper/): original LaTeX paper locations
- [overleaf](overleaf/): A submodule pointing at the Overleaf.com version of the paper ([read-only link](https://www.overleaf.com/read/nfkkgnxqvcyy), [git clone](https://git.overleaf.com/9025807zybmtjzwpjbm)).

## A note on Git submodules
This is somewhat tricky. The main repository lives on Github.com, but the text on Overleaf. Here's how this works with submodules:
```
git rm overleaf
git submodule add https://git.overleaf.com/9025807zybmtjzwpjbm overleaf
git branch -u origin/master master
git config -f .gitmodules submodule.overleaf.branch master
git add .gitmodules overleaf
git commit
```
- Initially, the submodule is added by `git submodule add <remoteurl> overleaf` (it doesn't seem to work out of the box - I believe this is the intent for submodules - to pin it to a certain version)
- Don't forget to commit `.gitmodules` to the master repo!
- To update it, run `git pull origin master` in the overleaf directory, or `git submodule sync` in the main directory.

See https://git-scm.com/docs/git-submodule for more information on submodules, and [this link](https://stackoverflow.com/questions/1777854/git-submodules-specify-a-branch-tag/18799234#18799234) for some of the issues.

An alternative might be to flip it around - to attach the Github program repo to a (offline) git clone of the overleaf, and literally pin it to a version there. Might make more sense.
