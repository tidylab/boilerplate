.First <- function(){
    # Helper Functions --------------------------------------------------------
    is_package_installed <- function(pkg) pkg %in% rownames(utils::installed.packages())

    set_repos_to_MRAN <- function(){
        options(repos = get_MRAN_URL())
    }

    get_MRAN_URL <- function(){
        MRAN_timestamp <- get_package_timestamp()
        paste0("https://mran.microsoft.com/snapshot/", MRAN_timestamp)
    }

    get_package_timestamp <- function(){
        desc_obj <- desc::description$new()
        tryCatch(as.Date(desc_obj$get_field("Date")), error = function(e) Sys.Date() - 1)
    }

    sink_command <- function(command){
        sink(tempfile())
        suppressMessages(eval(expr = parse(text = command)))
        sink()
    }

    copy_CONFIGURATION_from_root_to_inst <- function(){
        source <- "CONFIGURATION"
        target <- file.path("inst", "CONFIGURATION")
        dir.create(dirname(target), showWarnings = FALSE, recursive = TRUE)
        file.copy(from = source, to = target, overwrite = TRUE)
    }

    # Main --------------------------------------------------------------------
    #try({ # The expectation is needed when using CI
    if(is_package_installed("desc") == FALSE) utils::install.packages("desc")
    set_repos_to_MRAN()

    if(is_package_installed("devtools") == FALSE) utils::install.packages("devtools")
    sink_command("devtools::load_all(export_all = FALSE, helpers = FALSE)")

    if(is_package_installed("config") == FALSE) utils::install.packages("config")
    config::get(file = file.path(rprojroot::find_rstudio_root_file(), "CONFIGURATION"))
    copy_CONFIGURATION_from_root_to_inst()
    #}, silent = FALSE)
}

.Last <- function(){
    arrange_DESCRIPTION_requirements_alphabetically <- function(){
        deps <- desc::description$new()$get_deps() %>% dplyr::arrange(type, package)
        desc::description$new()$del_deps()$set_deps(deps)$write()
    }

    try(arrange_DESCRIPTION_requirements_alphabetically(), silent = TRUE)
}
