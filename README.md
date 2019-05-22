
# `tidylab.boilerplate`

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/tidylab/tidylab.boilerplate.svg?branch=master)](https://travis-ci.org/tidylab/tidylab.boilerplate)
[![Build
status](https://ci.appveyor.com/api/projects/status/ek5tuuy06k53lbk6/branch/master?svg=true)](https://ci.appveyor.com/project/harell/tidylab-boilerplate/branch/master)
[![Code coverage
status](https://codecov.io/gh/tidylab/tidylab.boilerplate/branch/master/graph/badge.svg)](https://codecov.io/github/tidylab/tidylab.boilerplate?branch=master)
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

1.  Clone `tidylab.boilerplate`
2.  Use the
    [`git-flow`](https://blog.sourcetreeapp.com/2012/08/01/smart-branching-with-sourcetree-and-git-flow/)
    approach in your development cycle.
3.  Change the `tidylab.boilerplate.Rproj` file to
    `<package-name>.Rproj`.
4.  Open the `DESCRIPTION` file, and edit the following fields:
    1.  **Package** modify the package name while using the `tidylab.`
        prefix.
    2.  **Title** modify the package title; use uppercase words with no
        period (‘.’).
    3.  **URL** modify the package URL such that it leads to its GitHub
        repo.
    4.  **BugReports** edit the URL such that it leads to the package
        issue page.
    5.  **Description** modify the package decription.
5.  In `README.Rmd` delete the **Useage** Section.
6.  Render `README.Rmd` by clicking the **Knit** button.

## Installation

`tidylab.boilerplate` is part of `tidylab`. The easiest way to install
it, is by installing `tidylab`:

    # Install all tidylab packages
    # install.packages("devtools")
    devtools::install_github("tidylab/tidylab")

Alternativly, you can install only `tidylab.boilerplate` by using:

    # Install only tidylab.boilerplate
    # install.packages("devtools")
    devtools::install_github("tidylab/tidylab.boilerplate")
