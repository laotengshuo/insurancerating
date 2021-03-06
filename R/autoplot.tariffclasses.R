#' Automatically create a ggplot for objects obtained from construct_tariff_classes()
#'
#' @description Takes an object produced by \code{construct_tariff_classes()}, and plots the fitted GAM.
#' In addition the constructed tariff classes are shown.
#'
#' @param object constructtariffclasses object produced by \code{construct_tariff_classes}
#' @param conf_int determines whether 95\% confidence intervals will be plotted. The default is \code{conf_int = FALSE}
#' @param color_gam a color can be specified either by name (e.g.: "red") or by hexadecimal code (e.g. : "#FF1234") (default is "steelblue")
#' @param color_splits change the color of the splits in the graph ("grey50" is default)
#' @param show_observations add observed frequency/severity points for each level of the variable for which tariff classes are constructed
#' @param size_points size for points (1 is default)
#' @param color_points change the color of the points in the graph ("black" is default)
#' @param rotate_labels rotate x-labels 45 degrees (this might be helpful for overlapping x-labels)
#' @param remove_outliers do not show observations above this number in the plot. This might be helpful for outliers.
#' @param ... other plotting parameters to affect the plot
#'
#' @return a ggplot object
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(dplyr)
#' fit_gam(MTPL, nclaims = nclaims, x = age_policyholder, exposure = exposure) %>%
#'    construct_tariff_classes(.) %>%
#'    autoplot(., show_observations = TRUE)
#' }
#'
#' @author Martin Haringa
#'
#' @export
autoplot.constructtariffclasses <- function(object, conf_int = FALSE, color_gam = "steelblue", show_observations = FALSE, color_splits = "grey50",
                                            size_points = 1, color_points = "black", rotate_labels = FALSE,
                                            remove_outliers = NULL, ...){

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 is needed for this function to work. Install it via install.packages(\"ggplot2\")", call. = FALSE)
  }

  if (!inherits(object, "constructtariffclasses")) {
    stop("autoplot.constructtariffclasses requires a constructtariffclasses object, use object = object")
  }

  prediction <- object[[1]]
  xlab <- object[[2]]
  ylab <- object[[3]]
  points <- object[[4]]
  gamcluster <- object[[6]]

  if(isTRUE(conf_int) & sum(prediction$upr_95 > 1e9) > 0){
    message("The confidence bounds are too large to show.")
  }

  if(is.numeric(remove_outliers) & isTRUE(show_observations)) {
    if (ylab == "frequency") points <- points[points$frequency < remove_outliers, ]
    if (ylab == "severity") points <- points[points$avg_claimsize < remove_outliers, ]
    if (ylab == "burning") points <- points[points$avg_premium < remove_outliers, ]
  }

  gam_plot <- ggplot(data = prediction, aes(x = x, y = predicted)) +
    geom_line(color = color_gam) +
    theme_bw(base_size = 12) +
    geom_vline(xintercept = gamcluster, color = color_splits, linetype = 2) +
    {if(isTRUE(conf_int) & sum(prediction$upr_95 > 1e9) == 0) geom_ribbon(aes(ymin = lwr_95, ymax = upr_95), alpha = 0.12)} +
    scale_x_continuous(breaks = gamcluster) +
    {if(isTRUE(show_observations) & ylab == "frequency") geom_point(data = points, aes(x = x, y = frequency), size = size_points, color = color_points)} +
    {if(isTRUE(show_observations) & ylab == "severity") geom_point(data = points, aes(x = x, y = avg_claimsize), size = size_points, color = color_points)} +
    {if(isTRUE(show_observations) & ylab == "burning") geom_point(data = points, aes(x = x, y = avg_premium), size = size_points, color = color_points)} +
    {if(ylab == "severity") scale_y_continuous(labels = scales::comma)} +
    {if(isTRUE(rotate_labels)) theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) } +
    labs(y = paste0("Predicted ", ylab), x = xlab)

  return(gam_plot)
}

