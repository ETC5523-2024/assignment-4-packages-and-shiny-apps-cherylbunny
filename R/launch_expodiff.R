
#' @export
launch_expodiff <- function() {
  app_dir <- system.file("app", package = "expodiff")
  shiny::runApp(app_dir, display.mode = "normal")
}
