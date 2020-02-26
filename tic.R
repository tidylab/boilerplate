#' Job Lifecycle
#'
#' 1. before_script
#' 2. script
#' 3. after_success or after_failure
#' 4. OPTIONAL before_deploy
#' 5. OPTIONAL deploy
#' 6. OPTIONAL after_deploy
#'

# Stage: Before Script ----------------------------------------------------
get_stage("before_script") %>%
    add_step(step_run_code(remotes::install_deps(dependencies = "Imports", build = FALSE, quiet = TRUE))) %>%
    add_step(step_run_code(try(devtools::uninstall(), silent = TRUE)))

# Stage: Script -----------------------------------------------------------
if("master" %in% ci_get_branch()){
    get_stage("script")

} else if ("develop" %in% ci_get_branch()){
    get_stage("script")

} else if (grepl("feature", ci_get_branch())){
    get_stage("script")

}


# if(ci_get_job_name() == "build"){
#     get_stage("script") %>%
#         add_step(step_run_code(devtools::document(quiet = TRUE))) %>%
#         add_step(step_rcmdcheck(error_on = "error"))
# } else if (tic::ci_get_branch() == "test") {
#     get_stage("script") %>%
#         add_step(step_run_code(devtools::load_all(export_all = FALSE))) %>%
#         add_step(step_run_code(testthat::test_dir("./tests/testthat")))
# }

# Stage: After Success ----------------------------------------------------
get_stage("after_success")

# Stage: After Failure ----------------------------------------------------
get_stage("after_failure") %>%
    add_step(step_run_code(print(sessioninfo::session_info(include_base = FALSE))))

# Stage: Before Deploy ----------------------------------------------------
get_stage("before_deploy")

# Stage: Deploy -----------------------------------------------------------
get_stage("deploy") %>%
    add_step(step_build_pkgdown())

# Stage: After Deploy -----------------------------------------------------
# get_stage("after_deploy") %>%
#     add_step(step_install_cran("covr")) %>%
#     add_step(step_run_code(covr::package_coverage(type = c("tests", "examples"), quiet = FALSE)))
