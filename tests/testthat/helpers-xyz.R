#  Expectations -----------------------------------------------------------
expect_dir_exists <- function(object) expect_true(dir.exists(object))
expect_file_exists <- function(object) expect_true(file.exists(object))

# Misc --------------------------------------------------------------------
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

