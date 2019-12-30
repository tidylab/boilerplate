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
                    "pkgdown" = private$build_site()
            )
        }
    ),

    private = list(
        is_job_name_known = function(job_name){
            job_name %in% c("coverage-report", "binder", "pkgdown")
        },
        codecov = function() {
            remotes::install_cran("covr", quiet = TRUE)
            Sys.setenv(TESTTHAT = "true")
            msg <- covr::codecov(quiet = FALSE)
            print(msg)
            Sys.setenv(TESTTHAT = "")
        },
        build_binder = function(){
            remotes::install_github("karthik/holepunch@0eec31cbefbb50ba142b2007103316bd6fbaef8a", quiet = TRUE)
            holepunch::write_install()
            holepunch::write_runtime()
            holepunch::build_binder()
        },
        build_site = function(){
            remotes::install_cran(c("fs", "pkgdown"), quiet = TRUE)
            fs::dir_copy("./.app", "./docs/.app")
            pkgdown::build_site()
        },
        job_name = character(),
        package_name = desc::description$new()$get_field("Package")
    )
)

step_deploy <- function(job_name){
    Deployable$new(job_name)
}
