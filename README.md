
# `boilerplate`

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/tidylab/boilerplate.svg?branch=master)](https://travis-ci.org/tidylab/boilerplate)
[![Code coverage
status](https://codecov.io/gh/tidylab/boilerplate/branch/master/graph/badge.svg)](https://codecov.io/github/tidylab/boilerplate?branch=master)
<!-- badges: end -->

Boilerplate for ‘tidylab’ Packages

-----

![Research factory](https://i.imgur.com/RLEQkhe.png)

<!-- Package Description -->

## Overview

As tidylab expands, new complexities arise. Using this boilerplate
reduces unnecessary variance between packages configurations.

<!--- Only relevant for the tidylab.boilerplate package -->

## Useage

1.  Create a new repo on GitHub.
2.  Use the
    [`git-flow`](https://blog.sourcetreeapp.com/2012/08/01/smart-branching-with-sourcetree-and-git-flow/)
    approach in your development cycle.
3.  Create a new release named `inception`.
4.  Copy `boilerplate` content to the new reposetory.
5.  Change the `tidylab.boilerplate.Rproj` file to
    `<package-name>.Rproj`.
6.  Open the `DESCRIPTION` file, and edit the following fields:
    1.  **Package** modify the package name while using the `tidylab.`
        prefix.
    2.  **Title** modify the package title; use uppercase words with no
        period (‘.’).
    3.  **URL** modify the package URL such that it leads to its GitHub
        repo.
    4.  **BugReports** edit the URL such that it leads to the package
        issue page.
    5.  **Description** modify the package decription.
7.  In `README.Rmd` delete the **Useage** Section.
8.  Render `README.Rmd` by clicking the **Knit** button.
9.  Push changed on the `inception` branch.
10. Setup CI/CD by running`usethis::use_travis()`.
11. Revert changes made on `.travis.yml`.
12. Cover the project on [codecov](https://codecov.io/github/tidylab).

## Installation

You can install `boilerplate` by using:

``` r
install.packages("devtools")
devtools::install_github("tidylab/`r package_name`")
```
