# Stage: Before Script ---------------------------------------------------------
get_stage("before_script") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_run_code(devtools::document())) %>%
    add_step(step_run_code(source(file.path(getwd(), ".tic", "TestSuite.R"))))

# Stage: Script ----------------------------------------------------------------
get_stage("script") %>%
    add_step(step_install_cran("desc")) %>%
    add_step(step_install_cran("testthat")) %>%
    add_step(step_run_test_suite())

# do_package_checks()

