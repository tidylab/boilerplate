library(tic)
if(!requireNamespace("desc")) remotes::install_version("desc", "1.2.0")
invisible(sapply(list.files("./.app/tic", full.names = TRUE), source))

# Stage : Before Install -------------------------------------------------------
get_stage("before_install") %>%
    add_step(step_run_code(Sys.getenv()))

# Stage: Install ---------------------------------------------------------------
get_stage("install") %>%
    add_step(step_run_code(set_repos_to_MRAN())) %>%
    add_step(step_install_cran("devtools", repos = get_MRAN_URL())) %>%
    add_step(step_install_deps(repos = get_MRAN_URL()))

# Stage: Script ----------------------------------------------------------------
get_stage("script") %>%
    add_step(step_run_code(devtools::document())) %>%
    add_step(step_build_and_check(job_name = ci_get_job_name())) %>%
    add_step(step_run_test_suite(job_name = ci_get_job_name())) %>%
    add_step(step_deploy(job_name = ci_get_job_name()))

# Stage: After Failure ---------------------------------------------------------
get_stage("after_failure") %>%
    add_step(step_run_code(show_error_log()))
