ci_get_job_name <- function() tolower(paste0(Sys.getenv("TRAVIS_JOB_NAME"), Sys.getenv("APPVEYOR_JOB_NAME")))
is_travis <- function() identical(Sys.getenv("TRAVIS"), "true")
is_integrating <- function() identical(Sys.getenv("CI"), "true")
install_package <- function(pkg){
    # Helper Functions ---------------------------------------------------------
    get_package_name <- function(pkg) sub("^.*/","", pkg)
    is_package_installed <- function(pkg) pkg %in% rownames(utils::installed.packages())
    install_form_GitHub <- function(pkg){
        message("--> Installing {", get_package_name(pkg), "} from GitHub")
        install_from_CRAN("devtools")
        devtools::install_github(pkg, dependencies = TRUE, upgrade = "never")
    }

    install_from_CRAN <- function(pkg){
        message("--> Installing {", get_package_name(pkg), "} from CRAN")
        utils::install.packages(
            pkg,
            dependencies = TRUE,
            Ncpus = parallel::detectCores()
        )
    }

    # Program Logic ------------------------------------------------------------
    if(is_package_installed(get_package_name(pkg))){
        return(invisible())
    } else if (grepl("/", pkg)){
        install_form_GitHub(pkg)
    } else {
        install_from_CRAN(pkg)
    }
    return(invisible())
}

set_repos_to_MRAN <- function(){
    options(repos = get_MRAN_URL())
    repos <- getOption("repos")
    message("Changed the default CRAN mirror to MRAN snapshot taken on ", gsub("^.*/", "", repos))
    invisible()
}

get_MRAN_URL <- function(){
    MRAN_timestamp <- .get_package_timestamp()
    paste0("https://mran.microsoft.com/snapshot/", MRAN_timestamp)
}

.get_package_timestamp <- function(){
    tryCatch(.get_field_from_DESCRIPTION("Date"), error = function(e) Sys.Date() - 1)
}

.get_field_from_DESCRIPTION <- function(field){
    .read_DESCRIPTION <- function() readLines("DESCRIPTION")
    field_regex <- paste0("^",field,":")
    Date_line <- .read_DESCRIPTION()[grep(field_regex, .read_DESCRIPTION())]
    Date <- trimws(sub(field_regex, "", Date_line))
}
