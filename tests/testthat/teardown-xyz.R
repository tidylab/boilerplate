################################################################################
##  Test Teardown: The code in this file runs after all tests are completed   ##
################################################################################
## Get project working directory
path_temp <- getwd()
while (length(grep("test", path_temp))>0) path_temp <- dirname(path_temp)
path_temp <- file.path(path_temp, "temp")

## Delete the template dirctory
unlink(path_temp, recursive = TRUE, force = TRUE)
rm(path_temp)
