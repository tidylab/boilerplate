source(file.path(getwd(), ".tic", "helpers-tic.R"))
source(file.path(getwd(), ".tic", "BuildAndCheck.R"))
source(file.path(getwd(), ".tic", "TestSuite.R"))
source(file.path(getwd(), ".tic", "Report.R"))

# Stage: Before Script ---------------------------------------------------------
get_stage("before_script") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_run_code(devtools::document()))

# Stage: Script ----------------------------------------------------------------
if(ci_get_job_name() %in% c("build")){
    get_stage("script") %>%
        add_step(step_build_and_check())

} else if(ci_get_job_name() %in% c("testthat", "component-tests", "integration-tests", "coverage-tests")){
    get_stage("script") %>%
        add_step(step_install_cran("desc")) %>%
        add_step(step_install_cran("testthat")) %>%
        add_step(step_run_test_suite(job_name = ci_get_job_name()))

} else if(ci_get_job_name() %in% c("coverage-report")){
    get_stage("script") %>%
        add_step(step_install_cran("covr")) %>%
        add_step(step_build_and_check(job_name = ci_get_job_name()))
}


