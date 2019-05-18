#######################
## Get Project Paths ##
#######################
## Remove the word "test" from the package path
path_project <- getwd()
while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
## Get package name
package_name <-  gsub(".Rcheck$", "", basename(path_project))
## Create other package paths
path_functions <- file.path(path_project, "R")
path_temp <- file.path(path_project, "temp")


###########################
## Load Project Packages ##
###########################
suppressPackageStartupMessages({
    library(testthat, character.only = FALSE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
    library(magrittr, character.only = FALSE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
    try(library(package_name, character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE))
})


############################
## Load Package Functions ##
############################
load_functions(path_functions)


################
## Unit Tests ##
################
message(rep("#",40), "\n## Running Unit Tests\n", rep("#",40))
test_dir(file.path(path_project, "tests", "testthat"))


#####################
## Component Tests ##
#####################
message(rep("#",40), "\n## Running Component Tests\n", rep("#",40))
test_dir(file.path(path_project, "tests", "component-tests"))


#######################
## Integration Tests ##
#######################
message(rep("#",40), "\n## Running Integration Tests\n", rep("#",40))
test_dir(file.path(path_project, "tests", "integration-tests"))


#############
## Cleanup ##
#############
unlink(path_temp, recursive = TRUE, force = TRUE)
suppressWarnings(rm(path_project, path_functions, path_temp))
