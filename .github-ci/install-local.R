# Helper functions -------------------------------------------------------------
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
    if(!require(package, character.only = TRUE))
        utils::install.packages(package,
                                repos = "https://cloud.r-project.org",
                                dependencies = TRUE,
                                Ncpus = parallel::detectCores()
        )
}

# Install local package --------------------------------------------------------
.install_development_packages()
.install_local_package()
