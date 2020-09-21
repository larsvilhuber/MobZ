#!/bin/bash

# create the output doc
Rscript -e "rmarkdown::render('README.Rmd', output_format = 'all', encoding = 'UTF-8');"
# create a PDF, for now externally
#export QT_STYLE_OVERRIDE=fusion 
#wkhtmltopdf README.html  README.pdf
