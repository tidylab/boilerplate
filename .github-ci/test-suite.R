###########
## Setup ##
###########
Sys.setenv(NOT_CRAN = "true")
job_name <- tolower(Sys.getenv("TRAVIS_JOB_NAME"))
message(rep("#",40), "\n", "## Test Suite: ", job_name, "\n", rep("#",40))

###########################################
## Install the Package Under Development ##
###########################################
devtools::install_local(
    path = ".",
    dependencies = TRUE,
    upgrade = FALSE,
    force = TRUE,
    build = FALSE,
    build_opts = "--no-multiarch --with-keep.source --no-build-vignettes",
    Ncpus = parallel::detectCores(),
    repos = "https://cloud.r-project.org"
)

#######################
## Get Project Paths ##
#######################
## Remove the word "test" from the package path
path_project <- getwd()
while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
## Get package name
package_name <- basename(path_project)
## Create other package paths
path_functions <- file.path(path_project, "R")
path_tests <- file.path(path_project, "tests", job_name)
path_temp <- file.path(path_project, "temp")

###############
## Run Tests ##
###############
library(package_name, character.only = TRUE)
testthat::test_dir(path_tests,
                   show_report = TRUE,
                   stop_on_failure = TRUE,
                   package = package_name)
