# Stage: Before Script ---------------------------------------------------------
get_stage("before_script") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_run_code(devtools::document()))

# Stage: Script ----------------------------------------------------------------
get_stage("script") %>%
    add_step(step_install_cran("desc")) %>%
    add_step(step_install_cran("testthat")) %>%
    add_step(step_run_code(library(desc::description$new()$get_field("Package"), character.only = TRUE))) %>%
    add_step(step_run_code(source(file.path(getwd(), ".tic", "helpers-tic.R")))) %>%
    add_step(step_run_code(
        testthat::test_dir(file.path(getwd(), "tests", ci_get_job_name()),
                           show_report = TRUE,
                           stop_on_failure = TRUE,
                           package = desc::description$new()$get_field("Package"))
    ))



# do_package_checks()

