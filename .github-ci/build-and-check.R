# Helper functions -------------------------------------------------------------
.get_installation_file_name <- function(){
    .install.packages("desc")
    desc_obj <- desc::description$new(.getwd())

    file_name <- desc_obj$get_field("Package") %+% "_" %+% desc_obj$get_field("Version")
    file_extension <- ".tar.gz"

    return(file_name %+% file_extension)
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

.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}

`%+%` <- function(a, b) paste0(a, b)

# Programming Logic -------------------------------------------------------
system("R CMD build . --no-build-vignettes --no-manual")
system("R CMD check $(ls -1t *.tar.gz | head -n 1) --no-manual")
# system("R CMD INSTALL " %+% .get_installation_file_name())
install.packages(.get_installation_file_name(), repos = NULL, type = "source",
                 dependencies = FALSE)
unlink(.get_installation_file_name(), recursive = TRUE, force = TRUE)
