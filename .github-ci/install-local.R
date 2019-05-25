# Helper functions -------------------------------------------------------------
.uninstall_local_package <- function(){
    try(remove.packages(.get_package_name()), silent = TRUE)
    return(invisible())
}

.install_development_packages <- function(){
    .install.packages("tidyverse")
    .install.packages("devtools")
    .install.packages("testthat")
    .install.packages("covr")
}

.install_local_package <- function(){
    .library("devtools")
    devtools::install_local(
        path = ".",
        dependencies = TRUE,
        upgrade = FALSE,
        force = FALSE,
        build = FALSE,
        build_opts = "--no-multiarch --with-keep.source --no-build-vignettes",
        Ncpus = parallel::detectCores(),
        repos = "https://cloud.r-project.org"
    )
}

.library <- function(package){
    .install.packages(package)
    library(package, character.only = TRUE)
}

.install.packages <- function(package){
    if(isFALSE(package %in% rownames(utils::installed.packages())))
        utils::install.packages(package,
                                repos = "https://cloud.r-project.org",
                                dependencies = TRUE,
                                Ncpus = parallel::detectCores()
        )
}

.get_package_name <- function(){
    return(gsub(".Rcheck$", "", basename(.getwd())))
}

.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}

# Install local package --------------------------------------------------------
.uninstall_local_package()
.install_development_packages()
.install_local_package()
