.First <- function(){
    path <- list.files(pattern = "^zzz.R$", all.files = TRUE, recursive = TRUE)
    stopifnot(length(path) == 1)
    source(path, TRUE)

    .copy_CONFIGURATION_from_root_to_inst()
    if(.is_package_installed("config"))
        .load_config(file = "CONFIGURATION", config = "session")
}

.Last <- function(){}
