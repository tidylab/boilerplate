# Helper functions -------------------------------------------------------------
.get_package_name <- function(){
    return(gsub(".Rcheck$", "", basename(.getwd())))
}

.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}

# Setup ------------------------------------------------------------------------
Sys.setenv(NOT_CRAN = "true")
job_name <- tolower(Sys.getenv("TRAVIS_JOB_NAME"))
message(rep("#",40), "\n", "## Test Suite: ", job_name, "\n", rep("#",40))
path_tests <- file.path(.getwd(), "tests", job_name)

# Run tests --------------------------------------------------------------------
try(library(.get_package_name(), character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE))
testthat::test_dir(path_tests,
                   show_report = TRUE,
                   stop_on_failure = TRUE,
                   package = package_name)
