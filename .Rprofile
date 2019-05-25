####################################
## Load Package Development Tools ##
####################################
pkgs <- list("devtools", "testthat", "usethis", "tidyverse", "desc")
suppressPackageStartupMessages(
    suppressWarnings(
        invisible(
            pkgs_flags <- sapply(pkgs, require, character.only = TRUE)
        )
    )
)
message("Preloaded ", sum(pkgs_flags), " out of ", length(pkgs), " packages See \".Rprofile\" for more details.")
rm(pkgs, pkgs_flags)


#########################
## Conflict Resolution ##
#########################
if("conflicted" %in% rownames(utils::installed.packages())){
    suppressPackageStartupMessages(suppressMessages(library("conflicted")))
    ## Resolve conflicts - persistently prefer one function over another
    suppressMessages({
        conflict_prefer("select", "dplyr")
        conflict_prefer("filter", "dplyr")
    })
    ## Show conflicts on startup
    #if(getOption("session.counter.call") == 0) conflicted::conflict_scout()
}
