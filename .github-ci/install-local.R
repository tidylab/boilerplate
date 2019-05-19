################################################################################
##                   Install the Package Under Development                    ##
################################################################################
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

