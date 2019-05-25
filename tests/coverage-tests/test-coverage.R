context("coverage tests for the package")
## For excluding lines/scripts from the coverage tests, see:
# ?covr::exclusions

test_that("unless stated otherwise, all scripts must surpass the code coverage threshold", {
    ###########
    ## Setup ##
    ###########
    .getwd <- function(){
        path_project <- getwd()
        while (length(grep("test", path_project))>0) path_project <- dirname(path_project)
        return(path_project)
    }

    ## Run code coverage
    covr_obj <- covr::package_coverage(path = .getwd(), quiet = TRUE)
    covr_list <- covr::coverage_to_list(covr_obj)

    ###########
    ## Tests ##
    ###########
    ## Check scripts code coverage
    for(e in seq_along(covr_list$filecoverage)){
        script_name <- names(covr_list[["filecoverage"]])[e]
        script_coverage <- unname(covr_list[["filecoverage"]][e])
        expect_gte(script_coverage, 75, label = script_name)
    }

    print(covr_list)
})
