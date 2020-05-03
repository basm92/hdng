#' Extract the data from the HDNG Database
#'
#' This function is used to extract variables indicated by the user from the database.
#' The user can specify which municipalities (gemeenten), and the possible years to look for.
#' @param variables Your query.
#' @param gemeenten The municipalities you want to extract the data for (defaults to all)
#' @param from Begin year (to be used in conjunction with to)
#' @param to End year (to be used in conjunction with from)
#' @param clean Filters the dataset to variables which are available at least once
#' @param col.names Gives you the description rather than the variable code as colnames.
#' @importFrom magrittr %>%
#' @import dplyr
#' @export
#' @return a data.frame of all queried municipalities and variables
#' @examples
#' hdng_get_data(c("aaa1", "bcx1", "qbx1"), gemeenten = c("Amsterdam", "Eindhoven"), from = 1800, to = 1900)
#' hdng_get_data("lpkm", from = 1900, to = 1950, clean = FALSE)

hdng_get_data <- function(variables,
                          gemeenten,
                          from = 1000,
                          to = 2000,
                          clean = TRUE,
                          col.names = FALSE) {

  lijst %>%
    select(c(1:5), all_of(variables)) -> query

  if(missing(gemeenten)){                     #Two trajectories: one without gemeenten
    query %>%
        filter(year >= from, year <= to) -> query   #Filter implements from, to and clean args

    if(clean == TRUE) {
      query %>%
        filter_at(vars(-c(1:5)), any_vars(!is.na(.))) -> query
    }

    else{
      query
    }
  }

  else {                                    #Two trajectories: one with gemeenten
    query %>%                     #Filter implements from, to, clean and gemeenten args
      filter(year >= from, year <= to, is.element(naam,toupper(gemeenten))) -> query

    if(clean == TRUE) {
      query %>%
        filter_at(vars(-c(1:5)), any_vars(!is.na(.))) -> query
    }

    else{
      query
    }
  }

  if(col.names == TRUE) {
    colnames(query)[-c(1:5)] <- variable_names[match(colnames(query),
                                                     variable_names$var),1]$descr[-c(1:5)]

    query
  }

  query

}
