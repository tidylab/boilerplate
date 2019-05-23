# Helper functions -------------------------------------------------------------
.install_local_package <- function(){
    .library("devtools")
    devtools::install_local(
        path = ".",
        dependencies = TRUE,
        upgrade = FALSE,
        force = TRUE,
        build = FALSE,
        build_opts = "--no-multiarch --with-keep.source --no-build-vignettes",
        Ncpus = parallel::detectCores(),
        repos = "https://cloud.r-project.org"
    )
}

.library <- function(package){
    if(!require(package, character.only = TRUE))
        utils::install.packages(package,
                                repos = "https://cloud.r-project.org",
                                dependencies = TRUE,
                                Ncpus = parallel::detectCores()
        )

    library(package, character.only = TRUE)
}

# Install local package --------------------------------------------------------
.install_local_package()



