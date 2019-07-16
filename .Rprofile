.First <- function(){
    ######################
    ## Helper Functions ##
    ######################
    copy_CONFIGURATION_from_root_to_inst <- function(){
        source <- "CONFIGURATION"
        target <- file.path("inst", "CONFIGURATION")
        dir.create(dirname(target), showWarnings = FALSE, recursive = TRUE)
        file.copy(from = source, to = target, overwrite = TRUE)
    }

    load_config <- function(value = NULL, config = Sys.getenv("R_CONFIG_ACTIVE", "default"),
                            file = Sys.getenv("R_CONFIG_FILE", "config.yml"), use_parent = TRUE){

        remove_special_apostrophe_from_yaml <- function(yaml_content){
            stopifnot(is.list(yaml_content))
            target_path <- tempfile()
            yaml::write_yaml(yaml_content, target_path)
            config <- readLines(target_path)
            config <- gsub("'!expr", "!expr", config)
            config <- gsub("('$)", "", config)
            return(config)
        }

        read_yaml_without_expression_evaluation <- function(file){
            yaml::read_yaml(
                file,
                eval.expr = FALSE,
                handlers = list(expr = function(x) {paste("!expr", x)})
            )
        }

        add_default_to_config <- function(config) unique(c("default", config))

        config <- add_default_to_config(config)
        yaml_content <- read_yaml_without_expression_evaluation(file)
        yaml_content <- yaml_content[config]
        yaml_content <- remove_special_apostrophe_from_yaml(yaml_content)

        yaml_path <- tempfile()
        base::get("writeLines")(text = yaml_content, con = yaml_path)

        suppressWarnings(
            config::get(value = value, config = config, file = yaml_path, use_parent = use_parent)
        )
    }

    is_package_installed <- function(package) package %in% rownames(utils::installed.packages())

    #######################
    ## Programming Logic ##
    #######################
    copy_CONFIGURATION_from_root_to_inst()
    if(is_package_installed("config")) load_config(file = "CONFIGURATION", config = "session")
}

.Last <- function(){}
