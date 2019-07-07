# Programming Logic -------------------------------------------------------
system("R CMD build . --no-build-vignettes --no-manual")
system("R CMD check $(ls -1t *.tar.gz | head -n 1) --no-manual")
