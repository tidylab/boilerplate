# high level steps --------------------------------------------------------
build_steps <- function(stage){
    stage %>%
        add_step(step_run_code(devtools::document(quiet = TRUE))) %>%
        add_step(step_rcmdcheck(error_on = "error"))
}

test_steps <- function(stage){
    stage %>%
        add_step(step_run_code(devtools::load_all(export_all = FALSE))) %>%
        add_step(step_run_code(testthat::test_dir("./tests/testthat")))
}

deploy_steps <- function(stage){
    stage %>%
        add_step(step_build_pkgdown())
}

# helper functions --------------------------------------------------------
ci_get_job_name <- function() tolower(paste0(Sys.getenv("TRAVIS_JOB_NAME"), Sys.getenv("APPVEYOR_JOB_NAME")))
