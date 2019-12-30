#' Step: Install Local Package
#'
#' Install the local package
#'
#' @family steps
#' @export
InstallLocal <- R6::R6Class(
    "InstallLocal", inherit = TicStep,
    public = list(
        run = function() {
            message("\n", rep("#",40), "\n", "## Installing the Current Package Version\n", rep("#",40))
            devtools::document()
            remotes::install_local(
                path = ".",
                dependencies = TRUE,
                upgrade = "never",
                force = FALSE,
                build = FALSE,
                build_opts = "--no-multiarch --with-keep.source --no-build-vignettes"
            )# end install_local
        }# end run
    )# end public
)#end InstallLocal

step_install_local_package <- function(){
    InstallLocal$new()
}
