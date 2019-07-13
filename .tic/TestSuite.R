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

        initialize = function(job_name){
            private$job_name <- job_name
        },

        run = function() {
            message("\n", rep("#",40), "\n", "## Test Suite: ",  private$job_name, "\n", rep("#",40))
            library(private$package_name, character.only = TRUE)
            testthat::test_dir(private$get_path_to_tests(),
                               show_report = TRUE,
                               stop_on_failure = TRUE,
                               package = private$package_name)
        }
    ),
    private = list(
        get_path_to_tests = function() file.path(getwd(), "tests", private$job_name),
        job_name = character(),
        package_name = desc::description$new()$get_field("Package")
    )
)

step_run_test_suite <- function(job_name){
    choices <- list.dirs(file.path(getwd(), "tests"), full.names = FALSE, recursive = FALSE)
    try(TestSuite$new(match.arg(tolower(job_name), choices)), silent = TRUE)
    return(invisible())
}
