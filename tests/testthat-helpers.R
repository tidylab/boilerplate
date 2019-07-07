# Expectations -----------------------------------------------------------------
expect_dir_exists_and_not_empty <- function(path){
    expect_dir_exists(path)
    expect_gte(length(list.files(path, pattern = ".*.R$")), 1)
}
expect_dir_exists <- function(path) expect_true(dir.exists(path))
expect_dir_does_not_exist <- function(path) expect_false(dir.exists(path))
expect_file_exists <- function(path) expect_true(file.exists(path))
expect_no_md_files <- function(path) expect_length(list.files(path, recursive = TRUE, all.files = TRUE, pattern = ".*.md"), 0)
expect_text_appears_in_document <- function(target, text) expect_true(any(grepl(text, readLines(target))))

# Setup and Teardown -----------------------------------------------------------
.create_temp_folder <- function() dir.create(.get_temp_dir(), showWarnings = FALSE, recursive = TRUE)
.delete_temp_folder <- function() unlink(.get_temp_dir(), recursive = TRUE, force = TRUE)

# testthat high-level functions ------------------------------------------------
.setup <- function(){
    try(.save_all(.get_projet_dir()), silent = TRUE)
    try(library(.get_package_name(), character.only = TRUE))
    if(.is_testing()) return(invisible())
    if(.is_developing()) return(invisible())

    try(devtools::document(pkg = .get_projet_dir()), silent = TRUE)
    try(devtools::load_all(path = .get_projet_dir()), silent = TRUE)
    invisible()
}

.run_unit_tests <- function(){
    if(.is_testing()) return(invisible())
    .title("Running Unit Tests")
    testthat::test_dir(file.path(.get_projet_dir(), "tests", "testthat"))
}

.run_component_tests <- function(){
    if(.is_testing()) return(invisible())
    .title("Running Component Tests")
    testthat::test_dir(file.path(.get_projet_dir(), "tests", "component-tests"))
}

.run_integration_tests <- function(){
    if(.is_testing()) return(invisible())
    .title("Running Integration Tests")
    testthat::test_dir(file.path(.get_projet_dir(), "tests", "integration-tests"))
}

.run_coverage_tests <- function(){
    if(.is_testing()) return(invisible())
    if(.is_developing()) return(invisible())
    .title("Running Coverage Tests")
    testthat::test_dir(file.path(.get_projet_dir(), "tests", "coverage-tests"))
}

.cleanup <- function(){
    path_temp <- file.path(.get_projet_dir(), 'temp')
    unlink(path_temp, recursive = TRUE, force = TRUE)
}

# testthat low-level functions -------------------------------------------------
.library <- function(package){
    suppressWarnings({
        if(!require(package, character.only = TRUE)){
            message("--> Installing {", package, "}")
            utils::install.packages(package,
                                    repos = "https://cloud.r-project.org",
                                    dependencies = TRUE,
                                    Ncpus = parallel::detectCores()
            )
        }
    })

    library(package, character.only = TRUE)
}

.save_all <- function()
{
    command <- '
    if (rstudioapi::hasFun("documentSaveAll")) {
        rstudioapi::documentSaveAll()
    }'
    eval(parse(text=command))
}

.title <- function(string){
    seperator <- paste0(rep("#", 80), collapse = "")
    message(paste0(c(seperator, paste("##", string), seperator), collapse = "\n"))
}

# Predicates -------------------------------------------------------------------
.are_disjoint_sets <- function(x, y){
    return(length(intersect(x, y)) == 0)
}

.is_subset <- function(x, y){
    return(length(setdiff(x, y)) == 0)
}

.is_testing <- function(){
    identical(Sys.getenv("TESTTHAT"), "true")
}

.is_developing <- function(){
    identical(Sys.getenv("DEVTOOLS_LOAD"), "true")
}

.is_not_on_cran <- function(){
    identical(Sys.getenv("NOT_CRAN"), "true")
}

# Misc -------------------------------------------------------------------------
.delete_and_create_dir <- function(path){
    stopifnot(path != .get_projet_dir())
    unlink(path, recursive = TRUE)
    dir.create(path, showWarnings = FALSE, recursive = TRUE)
    return(invisible())
}

.get_temp_dir <- function(){
    proj_path <- .get_projet_dir()
    path_temp <- file.path(proj_path, "temp")
    return(path_temp)
}

.get_projet_dir <- function(){
    proj_path <- getwd()
    while (length(grep("test", proj_path))>0) proj_path <- dirname(proj_path)
    return(proj_path)
}

.get_package_name <- function(){
    package_name <- devtools::dev_packages()
    package_name <- ifelse(length(package_name) == 0, basename(.get_projet_dir()), package_name)
    return(package_name)
}
