.getwd <- function(){
    path_project <- getwd()
    while (length(grep("test", path_project))>0)
        path_project <- dirname(path_project)
    message(path_project)
    return(path_project)
}
