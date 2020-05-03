#' Explore categories and variable names
#'
#' A function that helps the user explore the available variables.
#' The function returns all categories on an empty call, and
#' returns all variables in a category on a call with a category (typo robust)
#' allowing the user to efficiently gather variables for a data query.
#'
#' @param cat A category, defaults to NULL, gives a list of all categories
#' @param from Time frame for your query (start)
#' @param to Time frame for your query (end)
#' @param show.only.available Defaults to TRUE. Filters only variables which are available at least once.
#' @importFrom magrittr %>%
#' @import dplyr
#' @export
#' @seealso hdng::hdng_names_cats
#' @return a data.frame with var name, category, var code, and years of availability
#' @examples
#' hdng_names_cats()
#' hdng_names_cats("Beroepen", from = 1850, to = 1900)
#' hdng_names_cats(c("Politiek", "Woningen"))

hdng_names_cats <- function(cat, from = 1000, to = 2000, show.only.available = TRUE) {

  if(missing(cat)) { #Output for empty function call

    unique(variable_names$meaning)
  }

  else {

    match <- categories[stringdist::amatch(cat,
                               unique(
                                 variable_names$meaning #Typo proof
                               ),
                               maxDist = 5),2]

    isthere <- function(x) grepl("1", x)

    variable_names %>%
      filter(meaning == match) %>%
      select(c(1:4, num_range(prefix = NULL, from:to))) -> allvars
    # Basic dataset, only variables of category, and filter from and to

    plyr::colwise(isthere)(allvars) %>% #Compute whether the data is available at
      plyr::colwise(sum)(.) %>%         #Least once in the time period
      select_if(. > 0) %>%
      colnames() -> vars

    avail <- allvars %>%          #Filter the data to at least once available vars
      select(c(1:4), all_of(vars)) %>%
      .[rowSums(.[,-c(1:4)]) > 0,]

    if(show.only.available == FALSE) {
      allvars
    }

    else {
      avail
    }
  }
}
