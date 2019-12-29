# First -------------------------------------------------------------------
.First <- function(){}

# Second ------------------------------------------------------------------
local({
    tryCatch({
        source("./.app/tic/helper-functions.R")
        set_repos_to_MRAN()
    }, error = function(e) warning("Failed to modify the default CRAN mirror"))
})

# Last --------------------------------------------------------------------
.Last <- function(){}
