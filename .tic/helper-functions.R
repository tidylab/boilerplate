# High-level Functions ---------------------------------------------------------
.uninstall_local_package <- function(){
    message("\n","Uninstalling previous package version")
    try(remove.packages(.get_package_name()), silent = TRUE)
    return(invisible())
}

.install_development_packages <- function(){
    message("\n","Installing development tools")
    .install.packages("tidyverse")
    .install.packages("devtools")
    .install.packages("testthat")
    .install.packages("assertive")
    .install.packages("covr")
    .install.packages("callr")
}

.install_local_package <- function(){
    message("\n","Installing the current package version")
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

# Low-level Functions ----------------------------------------------------------
.library <- function(package){
    get_package_name <- function(x) gsub(".*/", "", x)

    .install.packages(package)
    library(get_package_name(package), character.only = TRUE)
}

.install.packages <- function(package){
    # Helper Functions
    get_package_name <- function(x) gsub(".*/", "", x)
    is_package_installed <- function(x) get_package_name(x) %in% rownames(utils::installed.packages())
    is_GitHub_repo_slug <- function(x) !identical(get_package_name(x), x)
    .install_from_CRAN <- function(x){
        utils::install.packages(get_package_name(x),
                                repos = "https://cloud.r-project.org",
                                dependencies = TRUE,
                                upgrade = "never",
                                Ncpus = parallel::detectCores())
    }
    .install_from_GitHub <- function(x){
        remotes::install_github(x,
                                ref = "master",
                                dependencies = TRUE,
                                upgrade = "never",
                                Ncpus = parallel::detectCores())
    }

    # Programming Logic
    if(is_package_installed(package)){
        invisible()
    } else if(is_GitHub_repo_slug(package)){
        .install.packages("remotes")
        .install_from_GitHub(package)
    } else {
        .install_from_CRAN(package)
    }

    return(invisible())
}

.get_package_name <- function(){
    return(gsub(".Rcheck$", "", basename(.getwd())))
}

.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}
