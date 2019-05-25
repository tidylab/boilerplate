context("unit test for load_functions")
#'
#' Case 1: folder with invalid functions
#' Case 2: folder with valid functions
#' Case 3: folder without files (empty folder)
#'
# case 1 -----------------------------------------------------------------------
test_that("load_functions works given a folder with invalid functions", {
    path_temp <- .get_temp_dir()
    .delete_and_create_dir(path_temp)

    # Create invalid functions
    ## Empty file
    empty_file_path <- file.path(path_temp, "empty_file.R")
    write.table("", empty_file_path, col.names = FALSE, row.names = FALSE, quote = FALSE)
    ## Script
    script_file_path <- file.path(path_temp, "two_plus_two.R")
    script_content <- "a <- 2 + 2"
    write.table(script_content, script_file_path, col.names = FALSE, row.names = FALSE, quote = FALSE)
    ## Broken function
    invalid_function_path <- file.path(path_temp, "invalid_function.R")
    function_content <- "invalid_function <- function(){return(NULL)#}"
    write.table(function_content, invalid_function_path, col.names = FALSE, row.names = FALSE, quote = FALSE)

    # Execute function on folder
    expect_null(load_functions(path = path_temp, envir = environment()))

    # Clean up: Delete the temporary folder
    unlink(path_temp, recursive = TRUE)
})

# case 2 -----------------------------------------------------------------------
test_that("load_functions works given a folder with valid functions", {
    path_temp <- .get_temp_dir()
    .delete_and_create_dir(path_temp)
    suppressWarnings(rm(foo, bar, .baz))

    # Create dummy functions named "foo.R" and "bar.r"
    # (upper and lower R file extensions)
    foo_path <- file.path(path_temp, "foo.R")
    bar_path <- file.path(path_temp, "bar.r")
    baz_path <- file.path(path_temp, ".baz.r")
    foo_content <- "foo <- function(){return(NULL)}"
    bar_content <- "bar <- function(){return(NULL)}"
    baz_content <- ".baz <- function(){return(NULL)}"
    write.table(foo_content, foo_path, col.names = FALSE, row.names = FALSE, quote = FALSE)
    write.table(bar_content, bar_path, col.names = FALSE, row.names = FALSE, quote = FALSE)
    write.table(baz_content, baz_path, col.names = FALSE, row.names = FALSE, quote = FALSE)

    # Execute function on the folder where "foo" is saved
    ## Make sure foo is not loaded
    expect_true(assertive::are_disjoint_sets(c("foo", "bar", ".baz"), ls(envir = environment())))
    ## Load all functions
    expect_silent(load_functions(path = path_temp, envir = environment()))
    ## Make sure foo and bar are loaded
    expect_true(assertive::is_subset(c("foo", "bar"), ls(envir = environment())))
    ## Make sure .baz is loaded
    expect_true(exists(".baz"))

    # Clean up
    ## Unload foo, bar and .baz
    suppressWarnings(rm(foo, bar, .baz))
    ## Delete the temporary folder
    unlink(path_temp, recursive = TRUE)
})

# case 3 -----------------------------------------------------------------------
test_that("load_functions works given a folder without files (empty folder)", {
    path_temp <- .get_temp_dir()
    .delete_and_create_dir(path_temp)

    # Execute function on an empty folder
    expect_null(load_functions(path = path_temp, envir = environment()))

    # Clean up: Delete the temporary folder
    unlink(path_temp, recursive = TRUE)
})
