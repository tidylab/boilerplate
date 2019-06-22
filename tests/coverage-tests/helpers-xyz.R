# Predicates -------------------------------------------------------------------
.are_disjoint_sets <- function(x, y){
    return(length(intersect(x, y)) == 0)
}

.is_subset <- function(x, y){
    return(length(setdiff(x, y)) == 0)
}

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

# Project Environment ----------------------------------------------------------
.delete_temp_project_env <- function() {
    try(get("assign")(x = ".project", value = NULL, envir = .GlobalEnv), silent = TRUE)
    try(detach(".project", character.only = TRUE), silent = TRUE)
    suppressWarnings(rm(.project))

    return(invisible())
}

.create_temp_project_env <- function() {
    .delete_temp_project_env()

    get("assign")(x = ".project", value = new.env(), envir = .GlobalEnv)
    get("attach")(.project, name = ".project")

    return(invisible())
}
