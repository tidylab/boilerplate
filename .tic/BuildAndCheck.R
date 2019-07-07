#' Step: Build and Check Package
#'
#' Build and check package
#'
#' @family steps
#' @export
BuildAndCheck <- R6::R6Class(
    "BuildAndCheck", inherit = TicStep,

    public = list(

        run = function() {
            message("\n", rep("#",40), "\n", "## Building and Checking Package\n", rep("#",40))
            system("R CMD build . --no-build-vignettes --no-manual")
            system("R CMD check $(ls -1t *.tar.gz | head -n 1) --no-manual")
        }
    )
)

step_build_and_check <- function(){
    BuildAndCheck$new()
}
