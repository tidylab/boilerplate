# Helper Functions -------------------------------------------------------------
.codecov <- function(){
    Sys.setenv(TESTTHAT = "true")
    covr::codecov()
    Sys.setenv(TESTTHAT = "")
}

# Setup ------------------------------------------------------------------------
job_name <- tolower(Sys.getenv("TRAVIS_JOB_NAME"))
message(rep("#",40), "\n", "## ", job_name, "\n", rep("#",40))

# Run Reports ------------------------------------------------------------------
switch (job_name,
        "coverage-report" = .codecov()
)
