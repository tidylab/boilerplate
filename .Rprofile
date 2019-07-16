.First <- function(){
    copy_CONFIGURATION_from_root_to_inst <- function(){
        source <- "CONFIGURATION"
        target <- file.path("inst", "CONFIGURATION")
        dir.create(dirname(target), showWarnings = FALSE, recursive = TRUE)
        file.copy(from = source, to = target, overwrite = TRUE)
    }

    copy_CONFIGURATION_from_root_to_inst()
    is_package_installed <- function(package) package %in% rownames(utils::installed.packages())
    if(is_package_installed("config"))
    invisible(config::get(file = "CONFIGURATION"))
}

.Last <- function(){}
