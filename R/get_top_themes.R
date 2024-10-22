#' Get Top Themes
#' 
#' Returns the top themes for World or Specialised Expos
#' 
#' @param expo_type Type of expo: World Expo or Specialised Expo
#' @return A dataframe of top themes
#' @export
get_top_themes <- function(expo_type = "World Expo") {
  if (expo_type == "World Expo") {
    return(combined_data$top_words_world)
  } else if (expo_type == "Specialised Expo") {
    return(combined_data$top_words_spec)
  } else {
    stop("Invalid expo type")
  }
}
