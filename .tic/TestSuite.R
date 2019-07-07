#' Step: Run Test-Suite
#'
#' Run one of "testthat", "component-tests", "integration-tests" or
#' "coverage-tests".
#'
#' @family steps
#' @export
TestSuite <- R6::R6Class(
    "TestSuite", inherit = TicStep,

    public = list(

        initialize <- function(job_name){
            private$job_name <- job_name
        },

        run = function() {

            package_name <- desc::description$new()$get_field("Package")

            library(package_name, character.only = TRUE)

            testthat::test_dir(file.path(private$path_tests, private$job_name),
                               show_report = TRUE,
                               stop_on_failure = TRUE,
                               package = package_name)
        }
    ),
    private = list(
        path_tests = file.path(getwd(), "tests"),
        job_name = character()
    )
)

step_run_test_suite <- function(job_name){
    TestSuite$new(job_name)
}
