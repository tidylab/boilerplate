library(tic)
if(!requireNamespace("desc")) install.packages("desc")
invisible(sapply(list.files("./.app/tic", full.names = TRUE), source))

# Stage: Install ----------------------------------------------------------
get_stage("install") %>%
    add_step(step_run_code(set_repos_to_MRAN())) %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_deps())

# Stage: Script ----------------------------------------------------------------
get_stage("script") %>%
    add_step(step_run_code(devtools::document())) %>%
    add_step(step_build_and_check(job_name = ci_get_job_name())) %>%
    add_step(step_run_test_suite(job_name = ci_get_job_name())) %>%
    add_step(step_render_report(job_name = ci_get_job_name()))

# Stage: After Failure ----------------------------------------------------------
get_stage("after_failure") %>%
    add_step(step_run_code(show_error_log()))
