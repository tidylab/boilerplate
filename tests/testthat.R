# Helper Functions -------------------------------------------------------------
.setup <- function(){
    try({
        cat("\014")
        save_all()
    }, silent = TRUE)

    return(invisible())
}

.load_packages <- function(){
    suppressPackageStartupMessages({
        library(testthat, character.only = FALSE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
        library(magrittr, character.only = FALSE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
        try(library(.get_package_name(), character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE))
    })
}

.load_functions <- function(){
    R_dir_path <- file.path(.getwd(), "R")
    scripts_paths <- list.files(R_dir_path, ".R", full.names = TRUE)

    if(length(scripts_paths) >= 0)
        invisible(sapply(scripts_paths, source))

    return(invisible())
}

.load_helper_functions <- function(){
    tests_dir_path <- file.path(.getwd(), "tests")
    scripts_paths <- list.files(tests_dir_path, "helpers-xyz.R",
                                full.names = TRUE, recursive = TRUE)
    if(length(scripts_paths) >= 0)
        invisible(sapply(scripts_paths, source))

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
    working_directory <- getwd()
    target <- .getwd()
    on.exit(working_directory)

    if(Sys.getenv("CI") != "") return(invisible())

    .title("Running Coverage Tests")

    command <- 'invisible(callr::r(function(pkg) devtools::document(pkg), list(pkg = target)))'
    if(interactive()) eval(parse(text=command))

    test_dir(file.path(target, "tests", "coverage-tests"))
}

.cleanup <- function(){
    path_temp <- file.path(.getwd(), 'temp')
    unlink(path_temp, recursive = TRUE, force = TRUE)
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
