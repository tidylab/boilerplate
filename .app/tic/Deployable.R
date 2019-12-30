#' Step: Render Reports
#'
#' Run one of "coverage-report".
#'
#' @family steps
#' @export
Deployable <- R6::R6Class(
    "Deployable", inherit = TicStep,

    public = list(

        initialize = function(job_name){
            private$job_name <- job_name
        },

        run = function() {
            if(private$is_job_name_known(private$job_name) == FALSE) return(invisible())
            message("\n", rep("#",40), "\n", "## Deploying: ",  private$job_name, "\n", rep("#",40))
            library(private$package_name, character.only = TRUE)
            switch (private$job_name,
                    "coverage-report" = private$codecov(),
                    "binder" = private$build_binder(),
                    "pkgdown" = private$pkgdown()
            )
        }
    ),

    private = list(
        is_job_name_known = function(job_name){
            job_name %in% c("coverage-report", "binder")
        },
        codecov = function() {
            Sys.setenv(TESTTHAT = "true")
            msg <- covr::codecov(quiet = FALSE)
            print(msg)
            Sys.setenv(TESTTHAT = "")
        },
        build_binder = function(){
            holepunch::write_install()
            holepunch::write_runtime()
            holepunch::build_binder()
        },
        pkgdown = function(){
            remotes::install_github("r-lib/pkgdown")
            tic::do_pkgdown(deploy = TRUE, orphan = TRUE, path = "docs", branch = "gh-pages")
        },
        job_name = character(),
        package_name = desc::description$new()$get_field("Package")
    )
)

step_deploy <- function(job_name){
    Deployable$new(job_name)
}
