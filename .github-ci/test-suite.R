# Helper functions -------------------------------------------------------------
.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}

# Setup ------------------------------------------------------------------------
Sys.setenv(NOT_CRAN = "true")
job_name <- tolower(Sys.getenv("TRAVIS_JOB_NAME"))
message(rep("#",40), "\n", "## Test Suite: ", job_name, "\n", rep("#",40))
path_project <- .getwd()
package_name <- basename(path_project)
path_tests <- file.path(path_project, "tests", job_name)

# Run tests --------------------------------------------------------------------
library(package_name, character.only = TRUE)
testthat::test_dir(path_tests,
                   show_report = TRUE,
                   stop_on_failure = TRUE,
                   package = package_name)
