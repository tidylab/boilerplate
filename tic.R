library(tic)
invisible(sapply(list.files("./.tic", full.names = TRUE), source))

# Stage: Before Install --------------------------------------------------------
get_stage("before_install") %>%
    add_step(step_install_cran("tidyverse")) %>%
    add_step(step_install_cran("remotes")) %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("testthat")) %>%
    add_step(step_install_cran("desc"))

# Stage: Install
get_stage("install") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_install_cran("desc")) %>%
    add_step(step_install_deps()) %>%
    add_step(step_install_local_package())

# Stage: Before Script ---------------------------------------------------------
get_stage("before_script") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_run_code(devtools::document()))

# Stage: Script ----------------------------------------------------------------
if(ci_get_job_name() %in% c("build")){
    get_stage("script") %>%
        add_step(step_build_and_check())

} else if(ci_get_job_name() %in% list.dirs(file.path(getwd(), "tests"), full.names = FALSE, recursive = FALSE)){
    get_stage("script") %>%
        add_step(step_install_cran("desc")) %>%
        add_step(step_install_cran("testthat")) %>%
        add_step(step_install_cran("covr")) %>%
        add_step(step_run_test_suite(job_name = ci_get_job_name()))

} else if(ci_get_job_name() %in% c("coverage-report", "build-binder")){
    get_stage("script") %>%
        add_step(step_install_cran("covr")) %>%
        add_step(step_install_github("karthik/holepunch")) %>%
        add_step(step_render_report(job_name = ci_get_job_name()))
}





