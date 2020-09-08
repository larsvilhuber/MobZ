#!/bin/bash

# create the output doc
Rscript -e "rmarkdown::render('template-README.Rmd',  encoding = 'UTF-8');"
# create a PDF, for now externally


export QT_STYLE_OVERRIDE=fusion 
wkhtmltopdf template-README.html  template-README.pdf