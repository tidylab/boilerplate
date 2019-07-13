#' Step: Render Reports
#'
#' Run one of "coverage-report".
#'
#' @family steps
#' @export
Report <- R6::R6Class(
    "Report", inherit = TicStep,

    public = list(

        initialize = function(job_name){
            private$job_name <- job_name
        },

        run = function() {
            message("\n", rep("#",40), "\n", "## Render Report: ",  private$job_name, "\n", rep("#",40))
            library(private$package_name, character.only = TRUE)
            switch (private$job_name,
                    "coverage-report" = private$codecov(),
                    "build-binder" = private$build_binder()
            )
        }
    ),
    private = list(
        codecov = function() {
            Sys.setenv(TESTTHAT = "true")
            covr::codecov()
            Sys.setenv(TESTTHAT = "")
        },
        build_binder = function(){
            holepunch::write_install()
            holepunch::write_runtime()
            holepunch::build_binder()
        },
        job_name = character(),
        package_name = desc::description$new()$get_field("Package")
    )
)

step_render_report <- function(job_name){
    Report$new(job_name)
}
