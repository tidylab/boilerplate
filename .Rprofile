# Load Package Development Tools -----------------------------------------------
pkgs <- list("devtools", "testthat", "usethis", "tidyverse", "desc", "tic")
suppressPackageStartupMessages(
    suppressWarnings(
        invisible(
            pkgs_flags <- sapply(pkgs, require, character.only = TRUE)
        )
    )
)
message("Preloaded ", sum(pkgs_flags), " out of ", length(pkgs), " packages See \".Rprofile\" for more details.")
rm(pkgs, pkgs_flags)

# Conflict Resolution ----------------------------------------------------------
if("conflicted" %in% rownames(utils::installed.packages())){
    suppressPackageStartupMessages(suppressMessages(library("conflicted")))
    ## Resolve conflicts - persistently prefer one function over another
    suppressMessages({
        conflict_prefer("select", "dplyr")
        conflict_prefer("filter", "dplyr")
    })
}

# Package Description Object ---------------------------------------------------
.First <- function(){
    try({
        DESCRIPTION <<- desc::description$new()
        options(DESCRIPTION = DESCRIPTION$clone())
    }, silent = TRUE)
}

.Last <- function(){
    try({
        if(!isTRUE(all.equal(DESCRIPTION, .Options$DESCRIPTION))){
            ans <- select.list(
                choices = c("Yes", "No"),
                title = "The package description file has changed. Do you want to save those changes?"
            )
            if(ans == "Yes")
                DESCRIPTION$write()
        }
    }, silent = TRUE)
}
