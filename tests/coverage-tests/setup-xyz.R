################################################################################
##        Test Setup: The code in this file runs before tests are run         ##
################################################################################
## Make sure the temp dir exists
dir.create(tempdir(), showWarnings = FALSE, recursive = TRUE)

## Make sure the package exists on the server
if(!"covr" %in% rownames(utils::installed.packages()))
    install.packages("covr",
                     repos = "https://cloud.r-project.org",
                     dependencies = TRUE,
                     Ncpus = parallel::detectCores())
