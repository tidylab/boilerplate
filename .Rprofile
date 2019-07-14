if(identical(Sys.getenv("TESTTHAT"), "true")){
    Sys.setenv(R_CONFIG_ACTIVE = "default")

} else if (identical(Sys.getenv("CI"), "true")) {
    Sys.setenv(R_CONFIG_ACTIVE = "default")

} else {
    Sys.setenv(R_CONFIG_ACTIVE = "development")

}

invisible(config::get(file = "CONFIGURATION"))

.First <- function(){}
.Last <- function(){}
