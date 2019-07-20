# High-level Functions ----------------------------------------------------
badge_custom <- function(x, y, color, url = "about::blank"){
    alt <- paste(x)
    x <- gsub(" ", "%20", x)
    y <- gsub(" ", "%20", y)
    x <- gsub("-", "--", x)
    y <- gsub("-", "--", y)
    badge <- paste0("![", alt, "](https://img.shields.io/badge/", x, "-",
                    y, "-", color, ".svg)")
    if (is.null(url))
        return(badge)
    paste0("[", badge, "](", url, ")")
}

plot_package_function_dependencies <- function(package_name){
    .install_package("mvbutils")
    fun_names <- .get_package_function_names(package_name)
    env_name <- .get_package_env_name(package_name)
    invisible(
        capture.output(
            deps <- mvbutils::foodweb(rprune = fun_names, where = env_name)
        )
    )
    # plot(deps)
}

# Low-level Functions -----------------------------------------------------
.install_package <- function(pkg){
    is_package_installed <- function(pkg) pkg %in% rownames(utils::installed.packages())

    if(is_package_installed(pkg)) return(invisible())

    message("--> Installing {", pkg, "}")
    utils::install.packages(pkg,
                            repos = "https://cloud.r-project.org",
                            dependencies = TRUE,
                            Ncpus = parallel::detectCores()
    )

    return(invisible())
}

.get_package_function_names <- function(package_name){
    X <- utils::lsf.str(pos = which(search() %in% .get_package_env_name(package_name)))
    as.vector(X)[!as.vector(X) %in% c("library.dynam.unload", "system.file")]
}

.get_package_env_name <- function(package_name){
    paste0("package:", package_name)
}
