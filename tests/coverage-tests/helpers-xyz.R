.get_projet_dir <- function(){
    proj_path <- getwd()
    while (length(grep("test", proj_path))>0) proj_path <- dirname(proj_path)
    return(proj_path)
}

