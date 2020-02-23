
# `template.package`

<!-- badges: start -->

[![Package
Website](https://img.shields.io/badge/Package%20Website-Click--Here-9cf.svg)](https://tidylab.github.io/template.package/)
[![Travis
Status](https://travis-ci.org/tidylab/template.package.svg?branch=master)](https://travis-ci.org/tidylab/template.package)
[![Code Coverage
Status](https://codecov.io/gh/tidylab/template.package/branch/master/graph/badge.svg)](https://codecov.io/github/tidylab/template.package/?branch=master)
<!-- badges: end -->

## Boilerplate for ‘tidylab’ Packages

## Overview

Any R package may include functions, tests, documentation and data.
While the content between packages is different, package development
tools and processes are often similar. `template.package` aims at:  
\* Letting the R programmer focus on what’s important – developing the
package content;  
\* Speeding-up development time by reducing rework time spent on
development tools setup; and  
\* Laying the infrastructure needed for some good software development
practices such as test-driven development.  
`template.package` includes:  
\* Fully configured test-suite, including code-coverage;  
\* Fully configured continuous-integration (CI) script for Travis; and  
\* Fully configured continuous-development (CD) script for Travis.

See the [package website](https://tidylab.github.io/template.package/)
for more information.

## Installation

You can install `template.package` by using:

    install.packages("devtools")
    devtools::install_github("tidylab/template.package")
