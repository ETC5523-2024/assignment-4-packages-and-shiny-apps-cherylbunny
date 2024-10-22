#' Get Economic Summary
#'
#' Returns a summary of economic factors 
#' 
#' @param expo_type Type of expo: World Expo or Specialised Expo
#' @return A dataframe of economic factors 
#' @export
get_econ_sum <- function(expo_type = "World Expo") {
  if (expo_type == "World Expo") {
    return(subset(combined_data$summary_combined, expo_type == "World Expo"))
  } else if (expo_type == "Specialised Expo") {
    return(subset(combined_data$summary_combined, expo_type == "Specialised Expo"))
  } else {
    stop("Invalid expo type")
  }
}
