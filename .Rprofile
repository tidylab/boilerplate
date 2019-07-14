if(identical(Sys.getenv("CI"), "") | identical(Sys.getenv("TESTTHAT"), "true")){
    Sys.setenv(R_CONFIG_ACTIVE = "development")
    invisible(config::get(file = "CONFIGURATION"))
}

.First <- function(){}
.Last <- function(){}
