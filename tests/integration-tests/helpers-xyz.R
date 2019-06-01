# Expectations -----------------------------------------------------------------
expect_dir_exists_and_not_empty <- function(path){
    expect_dir_exists(path)
    expect_gte(length(list.files(path, pattern = ".*.R$")), 1)
}
expect_dir_exists <- function(path) expect_true(dir.exists(path))
expect_dir_does_not_exist <- function(path) expect_false(dir.exists(path))
expect_file_exists <- function(path) expect_true(file.exists(path))

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

