
<!-- README.md is generated from README.Rmd. Please edit that file -->

# expodiff

<!-- badges: start -->
<!-- badges: end -->

The goal of expodiff is to provide an interactive exploration of World
Expos and Specialised Expos data, allowing users to visualize and
compare key metrics like attending countries, area size, visitors, and
economic factors. The package includes a Shiny app that enables dynamic
data exploration and interactive visualizations.

## Installation

You can install the development version of expodiff from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-cherylbunny")
```

## Example

This is a basic example which shows you how to load the library
`expodiff` and launch the shiny App:

``` r
# Load library 
library(expodiff)
# Launch Shiny App 
launch_expodiff()
```

The Shiny app provides various visualizations and comparisons, such as:

- Average attending countries over time for World and Specialised Expos.
- Correlation between area size and number of visitors.
- Top themes from Expos, ranked based on frequency.
- Economic factors and scale comparisons between different types of
  Expos.

## Data Summary

The data behind the expodiff package includes:

- World Expo and Specialised Expo data: Covering attending countries,
  visitors, cost, area, and themes.

- Interactive visualizations: Using plotly and ggplot2 to create
  responsive and dynamic charts.

- Economic analysis: A summary table comparing cost, visitors, and
  attending countries for World Expos and Specialised Expos.

## Example of Data Summary

You can summarize the built-in data sets:

``` r
# Load the combined dataset
data("combined_data", package = "expodiff")

# Example summary of attending countries
summary(combined_data$summary_combined)
#>   expo_type           mean_cost      median_cost    mean_visitors  
#>  Length:2           Min.   :557.9   Min.   : 40.0   Min.   :11.31  
#>  Class :character   1st Qu.:562.6   1st Qu.:117.5   1st Qu.:13.92  
#>  Mode  :character   Median :567.3   Median :195.0   Median :16.53  
#>                     Mean   :567.3   Mean   :195.0   Mean   :16.53  
#>                     3rd Qu.:572.0   3rd Qu.:272.5   3rd Qu.:19.15  
#>                     Max.   :576.7   Max.   :350.0   Max.   :21.76  
#>  median_visitors mean_attending_countries median_attending_countries
#>  Min.   : 8.20   Min.   :36.86            Min.   :23.00             
#>  1st Qu.:10.03   1st Qu.:39.12            1st Qu.:25.75             
#>  Median :11.85   Median :41.38            Median :28.50             
#>  Mean   :11.85   Mean   :41.38            Mean   :28.50             
#>  3rd Qu.:13.68   3rd Qu.:43.63            3rd Qu.:31.25             
#>  Max.   :15.50   Max.   :45.89            Max.   :34.00
```
