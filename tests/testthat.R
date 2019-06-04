# Helper Functions -------------------------------------------------------------
.setup <- function(){
    try(devtools::save_all(), silent = TRUE)
    # suppressMessages({
    #     capture.output(devtools::document())
    #     capture.output(devtools::load_all(export_all = FALSE))
    # })
    return(invisible())
}

.load_packages <- function(){
    suppressPackageStartupMessages({
        library(testthat, character.only = FALSE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
        try(library(.get_package_name(), character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE))
    })
}

.load_functions <- function(){
    R_dir_path <- file.path(.getwd(), "R")
    scripts_paths <- list.files(R_dir_path, ".R", full.names = TRUE)

    if(length(scripts_paths) >= 0)
        invisible(sapply(scripts_paths, base::source))

    return(invisible())
}

.load_helper_functions <- function(){
    tests_dir_path <- file.path(.getwd(), "tests")
    scripts_paths <- list.files(tests_dir_path, "helpers-xyz.R",
                                full.names = TRUE, recursive = TRUE)
    if(length(scripts_paths) >= 0)
        invisible(sapply(scripts_paths, base::source))

    return(invisible())
}

.run_unit_tests <- function(){
    .title("Running Unit Tests")
    test_dir(file.path(.getwd(), "tests", "testthat"))
}

.run_component_tests <- function(){
    .title("Running Component Tests")
    test_dir(file.path(.getwd(), "tests", "component-tests"))
}

.run_integration_tests <- function(){
    .title("Running Integration Tests")
    test_dir(file.path(.getwd(), "tests", "integration-tests"))
}

.run_coverage_tests <- function(){
    if(identical(Sys.getenv("TESTTHAT"), "true")) return(invisible())
    if(identical(Sys.getenv("DEVTOOLS_LOAD"), "true")) return(invisible())
    .unload_all()
    .title("Running Coverage Tests")
    test_dir(file.path(.getwd(), "tests", "coverage-tests"))
}

.cleanup <- function(){
    path_temp <- file.path(.getwd(), 'temp')
    unlink(path_temp, recursive = TRUE, force = TRUE)
    .unload_all()
}

save_all <- function()
{
    command <- '
    if (rstudioapi::hasFun("documentSaveAll")) {
        rstudioapi::documentSaveAll()
    }'
    eval(parse(text=command))
}

.get_package_name <- function(){
    return(gsub(".Rcheck$", "", basename(.getwd())))
}

.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    return(path_project)
}

.title <- function(string){
    seperator <- paste0(rep("#", 80), collapse = "")
    message(paste0(c(seperator, paste("##", string), seperator), collapse = "\n"))
}

.unload_all <- function(){
    package_name <- devtools::dev_packages()
    package_name <- ifelse(length(package_name) == 0, basename(.getwd()), package_name)
    try(detach(paste("package", package_name, sep = ":"), character.only = TRUE), silent = TRUE)
    try(detach("devtools_shims", unload = TRUE), silent = TRUE)
    return(invisible())
}

# Programming Logic ------------------------------------------------------------
.setup()

.load_packages()
.load_functions()
.load_helper_functions()

.run_unit_tests()
.run_component_tests()
.run_integration_tests()
.run_coverage_tests()

.cleanup()

