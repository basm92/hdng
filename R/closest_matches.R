#' Find the closest n variables to your search query
#'
#' This function returns a matrix of n rows and length(a) columns with all names
#' of the closest matches of the variables to the user's query,
#' allowing the user to efficiently gather variables for a data query.
#'
#' @param a Your query, a character vector
#' @param category If you want to search within a particular category (hdng_names_cats)
#' @param n The amount of variables you want to return.
#' @param variable.names = FALSE. Whether you want to include the description or the abbreviation.
#' @param ... Arguments to be passed on to `stringdist::stringdistmatrix`.
#' @export
#' @importFrom magrittr %>%
#' @seealso hdng::hdng_names_cats
#' @return a matrix of n rows and length(a) columns
#' @examples
#' closest_matches(c("Verkeer", "Bevolking"), n = 20, variable.names = T)
#' closest_matches(c("Aaantal vrachtwagens", "Aantal autos", "Schoolgaande kinderen"), n = 30)


closest_matches <- function(a, category = NULL, n = 10, variable.names = FALSE, ...){

  if(!missing(category)) {

    if(!is.element(category, variable_names$meaning)){
      stop('Please enter a valid category')
    }

    variable_names <- variable_names %>%
      filter(is.element(meaning, category))
  }

  matrix <- stringdist::stringdistmatrix(a,variable_names$descr, ...)
  temp <- list()

  for(i in 1:nrow(matrix)) {
    as.data.frame(matrix) %>%
      .[i, order(matrix[i,], decreasing = F)] %>%
      colnames() %>%
      stringr::str_remove_all(., "V") %>%
      as.numeric() -> temp[[i]]
  }

  if(length(a) > 1) {
    temp <- temp %>% #More keywords
      purrr::reduce(rbind) %>%
      .[,1:n]
  }

  else {
    temp <- temp %>% #1 keyword ###DEBUG: Dit object heeft geen rijen, en die zijn nodig voor for loop
      purrr::reduce(rbind) %>%
      .[1:n] %>%
      matrix(., ncol = n)           #solution: matrix - causes other bugs.. fuck
  }

  out <- NULL

  if(variable.names == TRUE){

    for(j in 1:nrow(temp)){
      out[[j]] <- variable_names$descr[temp[j,]]
    }

  }

  else {

    for(j in 1:nrow(temp)){
      out[[j]] <- variable_names$var[temp[j,]]
    }
  }

  out <- out %>%
    purrr::reduce(cbind)

  if(length(a) > 1) {
    colnames(out) <- a
    out
  }

  else {
    out
  }

}
