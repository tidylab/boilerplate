.First <- function(){
    # Helper Functions --------------------------------------------------------
    is_package_installed <- function(pkg) pkg %in% rownames(utils::installed.packages())
    is_integrating <- function() identical(Sys.getenv("CI"), "true")

    sink_command <- function(command){
        sink(tempfile())
        suppressMessages(eval(expr = parse(text = command)))
        sink()
    }

    print_welcome_message <- function(){
        print_n_hashtags(80)
        message("## Running .Rprofile")
        print_n_hashtags(80)
    }

    # Main --------------------------------------------------------------------
    if(is_integrating()) return(invisible())

    if(is_package_installed("desc") == FALSE) utils::install.packages("desc")

    if(is_package_installed("devtools") == FALSE) utils::install.packages("devtools")
    sink_command("devtools::load_all(export_all = FALSE, helpers = FALSE)")

    if(is_package_installed("config") == FALSE) utils::install.packages("config")
    config::get(file = file.path(rprojroot::find_rstudio_root_file(), "CONFIGURATION"))
}

.Last <- function(){
    arrange_DESCRIPTION_requirements_alphabetically <- function(){
        deps <- desc::description$new()$get_deps() %>% dplyr::arrange(type, package)
        desc::description$new()$del_deps()$set_deps(deps)$write()
    }

    try(arrange_DESCRIPTION_requirements_alphabetically(), silent = TRUE)
}
