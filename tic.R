source(file.path(getwd(), ".tic", "helper-functions.R"))

# Install local package --------------------------------------------------------
.uninstall_local_package()
.install_development_packages()
.install_local_package()


do_package_checks()

# if (ci_on_travis()) {
#   do_pkgdown()
# }
