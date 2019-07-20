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
