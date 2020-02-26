ci_get_job_name <- function() tolower(paste0(Sys.getenv("TRAVIS_JOB_NAME"), Sys.getenv("APPVEYOR_JOB_NAME")))


# high level steps --------------------------------------------------------
build_steps <- function(stage){
    return(stage)
}

test_steps <- function(stage){
    return(stage)
}

deploy_steps <- function(stage){
    return(stage)
}

