source(file.path(getwd(), ".tic", "helper-functions.R"))

# Stage: Before Script ---------------------------------------------------------
get_stage("before_script") %>%
    add_step(step_run_code(Sys.setenv(TESTTHAT = "true"))) %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_cran("roxygen2")) %>%
    add_step(step_run_code(devtools::document()))








# Stage: Install ---------------------------------------------------------------
# dev_packages <- c("tidyverse", "devtools", "testthat", "covr")
# get_stage("install") %>%
#     add_step(step_install_cran(
#         package = dev_packages,
#         repos = "https://cloud.r-project.org",
#         dependencies = TRUE,
#         upgrade = "never",
#         Ncpus = parallel::detectCores()
#     ))

# Install local package --------------------------------------------------------
# .uninstall_local_package()
# .install_development_packages()
# .install_local_package()


do_package_checks()

# if (ci_on_travis()) {
#   do_pkgdown()
# }
