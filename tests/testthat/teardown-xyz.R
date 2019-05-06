################################################################################
##  Test Teardown: The code in this file runs after all tests are completed   ##
################################################################################
## Get project working directory
path_project <- getwd()
while (length(grep("test", path_project))>0) path_project <- dirname(path_project)

## Delete the template dirctory
unlink(file.path(path_project, "temp"), recursive = TRUE, force = TRUE)
rm(path_project)
