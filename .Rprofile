# First -------------------------------------------------------------------
.First <- function(){
    is_integrating <- function() identical(Sys.getenv("CI"), "true")
    if(is_integrating()) return()
    packages <- c("devtools", "usethis", "testthat", "tidyverse", "desc")

    local({
        tryCatch({
            source("./.app/tic/helper-functions.R")
            require <- function(...) suppressPackageStartupMessages(base::require(...))
            set_repos_to_MRAN()
            sapply(packages, install_package)
            sapply(packages, require, character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE)
        }, error = function(e) warning("Failed to modify the default CRAN mirror"))
    })

    return(invisible())
}
# Second ------------------------------------------------------------------


# Last --------------------------------------------------------------------
.Last <- function(){
    is_integrating <- function() identical(Sys.getenv("CI"), "true")
    if(is_integrating()) return()

    return(invisible())
}
