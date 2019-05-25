# foo --------------------------------------------------------------------------
#
#' @title Compose a Message with an Entity Name and Age
#'
#' @description Given \code{name} and \code{age}, when \code{foo} is
#'   called, then a string with that entity details is composed and returned.
#'
#' @param name (`character`) The name of the entity.
#' @param age (`numeric`) The age of the entity.
#'
#' @return (`character`) A string with the entity's details.
#' @export
#'
#' @examples
#' \dontrun{
#' msg <- foo('Earth', 4.543e9)
#' message(msg)
#' }
#'
foo <- function(name, age){
    is_a_non_empty_string <- function(x) is.character(x) & length(x) == 1 & nchar(x) > 0
    is_a_positive_number <- function(x) is.numeric(x) & length(x) >= 1 & x >= 0

    stopifnot(isFALSE(missing(name)), is_a_non_empty_string(name),
              isFALSE(missing(age)), is_a_positive_number(age))

    age <- format(age, scientific = FALSE)
    msg <- paste(name, 'is', age, 'years old')

    return(msg)
}


