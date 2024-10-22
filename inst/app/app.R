# Load packages and data
library(tidyverse)
library(shiny)
library(plotly)
library(gridExtra)
library(gt)

data("combined_data", package = "expodiff")

# UI
ui <- navbarPage(
  title = "Expo Data Dashboard",

  # First Tab: Average Attending Countries
  tabPanel("Average Attending Countries",
           sidebarLayout(
             sidebarPanel(
               checkboxGroupInput("expo_type", "Select Expo Type(s):",
                                  choices = c("World Expo", "Specialised Expo"),
                                  selected = "World Expo")
             ),
             mainPanel(
               plotlyOutput("attending_countries_plot")
             )
           )
  ),

  # Second Tab: Area Size vs. Visitors (Side-by-Side)
  tabPanel("Area vs. Visitors",
           fluidRow(
             column(6, plotlyOutput("area_plot_world")),
             column(6, plotlyOutput("area_plot_specialised"))
           )
  ),

  # Third Tab: Top Themes
  tabPanel("Top Themes",
           fluidRow(
             column(6, plotOutput("top_words_world")),
             column(6, plotOutput("top_words_spec"))
           )
  ),

  # Fourth Tab: Economic Factors
  tabPanel("Economic Factors",
           fluidRow(
             column(12, gt_output("economic_table"))
           )
  )
)


# Server
server <- function(input, output) {

  # First Plot: Average Attending Countries Over Time
  output$attending_countries_plot <- renderPlotly({
    avg_attend_combined <- world_fairs %>%
      group_by(start_year, category) %>%
      summarise(avg_countries = mean(attending_countries, na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(expo_type = ifelse(category == "World Expo", "World Expo", "Specialised Expo"))

    filtered_data <- avg_attend_combined %>%
      filter(expo_type %in% input$expo_type)

    p <- ggplot(filtered_data, aes(x = start_year, y = avg_countries, color = expo_type)) +
      geom_point(size = 2) +
      theme_linedraw() +
      ggtitle("Average Attending Countries Over Time") +
      xlab("Year") +
      ylab("Average Number of Attending Countries") +
      scale_color_manual(name = "Exposition Type", values = c("World Expo" = "#00AFBB", "Specialised Expo" = "#FC4E07"))

    ggplotly(p)
  })

  # Second Plot: Correlation Between Area Size and Number of Visitors
  output$area_plot_world <- renderPlotly({
    filtered_data <- world_fairs %>%
      filter(category == "World Expo")

    p <- ggplot(filtered_data, aes(x = area, y = visitors)) +
      geom_point(size = 2) +
      geom_smooth(method = "lm") +
      ggtitle("World Expo: Area Size vs Visitors") +
      xlab("Area Size") +
      ylab("Visitors")

    ggplotly(p)
  })

  output$area_plot_specialised <- renderPlotly({
    filtered_data <- world_fairs %>%
      filter(category == "Specialised Expo")

    p <- ggplot(filtered_data, aes(x = area, y = visitors)) +
      geom_point(size = 2) +
      geom_smooth(method = "lm") +
      ggtitle("Specialised Expo: Area Size vs Visitors") +
      xlab("Area Size") +
      ylab("Visitors")

    ggplotly(p)
  })

  # Third Plot: Top Themes of Expos
  output$top_words_world <- renderPlot({
    top_words_world_plot <- ggplot(top_words_world, aes(x = reorder(word, n), y = n)) +
      geom_bar(stat = "identity", fill = "#00AFBB") +
      coord_flip() +
      xlab('Word') +
      ylab('Frequency') +
      theme_minimal()

    print(top_words_world_plot)
  })

  output$top_words_spec <- renderPlot({
    top_words_spec_plot <- ggplot(top_words_spec, aes(x = reorder(word, n), y = n)) +
      geom_bar(stat = "identity", fill = "#FC4E07") +
      coord_flip() +
      xlab('Word') +
      ylab('Frequency') +
      theme_minimal()

    print(top_words_spec_plot)
  })

  # Fourth Plot: Economic Factors Table
  output$economic_table <- render_gt({
    summary_combined %>%
      gt() %>%
      tab_header(
        title = "Comparison of Economic Factors and Scale of Events",
        subtitle = "World Expo vs Specialised Expo"
      ) %>%
      tab_spanner(
        label = "Cost",
        columns = c(mean_cost, median_cost)
      ) %>%
      tab_spanner(
        label = "Visitors",
        columns = c(mean_visitors, median_visitors)
      ) %>%
      tab_spanner(
        label = "Attending Countries",
        columns = c(mean_attending_countries, median_attending_countries)
      ) %>%
      cols_label(
        expo_type = "Expo Type",
        mean_cost = "Mean",
        median_cost = "Median",
        mean_visitors = "Mean",
        median_visitors = "Median",
        mean_attending_countries = "Mean",
        median_attending_countries = "Median"
      ) %>%
      fmt_number(
        columns = c(mean_cost, median_cost, mean_visitors, median_visitors, mean_attending_countries, median_attending_countries),
        decimals = 2
      ) %>%
      tab_options(
        table.font.size = "small",
        table.align = "center"
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
