context("coverage tests for the package")
## For excluding lines/scripts from the coverage tests, see:
# ?covr::exclusions

test_that("unless stated otherwise, all scripts must surpass the code coverage threshold", {
    ###########
    ## Setup ##
    ###########
    ## Get project path
    path_project <- getwd()
    while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
    ## Run code coverage
    covr_obj <- covr::package_coverage(path = path_project, quiet = TRUE)
    covr_list <- covr::coverage_to_list(covr_obj)
    print(covr_list)


    ###########
    ## Tests ##
    ###########
    ## Check package code coverage
    expect_gte(covr_list$totalcoverage, 75, label = "Overall Package Code Coverage")
    ## Check scripts code coverage
    for(e in seq_along(covr_list$filecoverage)){
        script_name <- names(covr_list[["filecoverage"]])[e]
        script_coverage <- unname(covr_list[["filecoverage"]][e])
        expect_gte(script_coverage, 75, label = script_name)
    }
})
