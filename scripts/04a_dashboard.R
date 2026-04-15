# =============================================================================
# 04a_dashboard.R
# Interactive Shiny dashboard for exploring water availability results.
#
# Features:
#   - Leaflet map: click a subcatchment to select it
#   - Dropdowns: scenario, statistic, season
#   - Seasonal statistics table and bar chart for selected subcatchment
#   - Hydrograph panel for nearest gauge (if available)
#   - Plain language interpretation of selected values
#
# Run with:
#   shiny::runApp("scripts/04a_dashboard.R")
# =============================================================================

library(shiny)
library(leaflet)
library(sf)
library(jsonlite)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")

# -----------------------------------------------------------------------------
# Load data once at startup
# -----------------------------------------------------------------------------
message("Loading data...")

scenario_files <- list(
  baseline = "water_availability_region.gpkg",
  climate  = "water_availability_region_climate.gpkg",
  urban    = "water_availability_region_urban.gpkg",
  combined = "water_availability_region_combined.gpkg"
)

# Load all 4 scenarios and transform to WGS84 for leaflet
wa <- lapply(names(scenario_files), function(s) {
  sf_obj <- st_read(file.path(results_dir, scenario_files[[s]]), quiet = TRUE)
  st_transform(sf_obj, 4326)
})
names(wa) <- names(scenario_files)

# Load GOF metrics
metrics <- read.csv(file.path(repo, "tables", "gof_metrics.csv"))

# Load discharge timeseries — one per catchment, store in named list
catchment_dirs <- list.dirs(
  file.path(results_dir, "model_setups/catchments"),
  recursive = FALSE
)

discharge <- lapply(catchment_dirs, function(d) {
  path <- file.path(d, "catch_data", "calib_disch_data_results.csv")
  if (!file.exists(path)) return(NULL)
  df      <- read.csv(path)
  df$Date <- as.Date(df$Date)
  df
})
names(discharge) <- basename(catchment_dirs)

message("Data loaded.")

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------
scenario_labels <- c(
  baseline = "Baseline (2020-2023)",
  climate  = "Climate change (SSP2-4.5)",
  urban    = "Urban growth (to 2040)",
  combined = "Combined (climate + urban)"
)

stat_labels <- c(
  min    = "Minimum",
  q10    = "Q10 (low-flow indicator)",
  median = "Median",
  mean   = "Mean",
  max    = "Maximum"
)

season_labels <- c(
  winter = "Winter (Dec-Feb)",
  spring = "Spring (Mar-May)",
  summer = "Summer (Jun-Aug)",
  autumn = "Autumn (Sep-Nov)",
  annual = "Annual"
)

seasons <- c("winter", "spring", "summer", "autumn", "annual")

# -----------------------------------------------------------------------------
# Colour palette helper
# -----------------------------------------------------------------------------
make_pal <- function(vals, n = 9) {
  colorNumeric(
    palette = c("#f7fbff", "#c6dbef", "#6baed6", "#2171b5", "#08306b"),
    domain  = vals,
    na.color = "#cccccc"
  )
}

# -----------------------------------------------------------------------------
# Interpretation helper
# -----------------------------------------------------------------------------
interpret <- function(catchment_name, subcatch_id, scenario, stat, season, val) {
  if (is.na(val)) return("No data available for this subcatchment.")

  stat_desc <- switch(stat,
    min    = "minimum",
    q10    = "Q10 (the flow exceeded 90% of the time — a reliable low-flow estimate)",
    median = "median",
    mean   = "mean",
    max    = "maximum"
  )

  scenario_desc <- switch(scenario,
    baseline = "under current conditions (2020-2023)",
    climate  = "under the SSP2-4.5 climate change scenario (2040-2069)",
    urban    = "under the urban growth scenario (to 2040)",
    combined = "under the combined climate change and urban growth scenario"
  )

  season_desc <- switch(season,
    winter = "winter (December-February)",
    spring = "spring (March-May)",
    summer = "summer (June-August)",
    autumn = "autumn (September-November)",
    annual = "across the full year"
  )

  low_flag <- val < 0.05
  very_low <- val < 0.01

  base_text <- sprintf(
    "The %s discharge %s in %s is %.4f m³/s, %s.",
    stat_desc, season_desc, scenario_desc, val,
    ifelse(very_low, "which is extremely low and may be insufficient for industrial water abstraction",
    ifelse(low_flag, "which is low and may constrain continuous water abstraction for hydrogen production",
                     "suggesting reasonable water availability for this period"))
  )

  if (stat == "q10") {
    base_text <- paste0(base_text,
      " The Q10 statistic represents the near-guaranteed minimum supply ",
      "relevant to continuous industrial abstraction — it is the primary ",
      "indicator used in this study for hydrogen production site screening.")
  }

  base_text
}

# -----------------------------------------------------------------------------
# UI
# -----------------------------------------------------------------------------
ui <- fluidPage(

  titlePanel("Water Availability for Hydrogen Production — Southern Finland"),

  tags$head(tags$style(HTML("
    .well { background-color: #f8f9fa; border: 1px solid #dee2e6; }
    .info-box { background: white; border: 1px solid #dee2e6;
                border-radius: 4px; padding: 12px; margin-top: 10px; }
    .metric-val { font-size: 1.4em; font-weight: bold; color: #2171b5; }
    .interpret-text { font-size: 0.88em; color: #444; line-height: 1.5; }
    h4 { color: #2c3e50; }
  "))),

  sidebarLayout(

    sidebarPanel(width = 3,

      selectInput("scenario", "Scenario:",
                  choices  = setNames(names(scenario_labels), scenario_labels),
                  selected = "baseline"),

      selectInput("stat", "Statistic:",
                  choices  = setNames(names(stat_labels), stat_labels),
                  selected = "q10"),

      selectInput("season", "Season (map display):",
                  choices  = setNames(names(season_labels), season_labels),
                  selected = "summer"),

      hr(),

      h4("Selected subcatchment"),
      div(class = "info-box",
        uiOutput("selected_info")
      ),

      hr(),

      h4("Interpretation"),
      div(class = "info-box interpret-text",
        uiOutput("interpretation")
      )
    ),

    mainPanel(width = 9,

      # Map
      leafletOutput("map", height = "380px"),

      hr(),

      fluidRow(

        # Seasonal statistics
        column(6,
          h4("Seasonal statistics — selected subcatchment"),
          tableOutput("stats_table"),
          plotOutput("stats_bar", height = "200px")
        ),

        # Hydrograph
        column(6,
          h4("Hydrograph — nearest gauge"),
          uiOutput("gauge_info"),
          plotOutput("hydrograph", height = "260px")
        )
      )
    )
  )
)

# -----------------------------------------------------------------------------
# Server
# -----------------------------------------------------------------------------
server <- function(input, output, session) {

  # Reactive: current scenario data
  current_wa <- reactive({
    wa[[input$scenario]]
  })

  # Reactive: selected subcatchment index (from map click)
  selected_idx <- reactiveVal(NULL)

  # -----------------------------------------------------------------------------
  # Map
  # -----------------------------------------------------------------------------
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(lng = 25.5, lat = 60.2, zoom = 7)
  })

  # Update map colours when scenario/stat/season changes
  observe({
    sf_obj   <- current_wa()
    col_name <- paste0(input$season, "_", input$stat)
    vals     <- sf_obj[[col_name]]
    pal      <- make_pal(vals)

    leafletProxy("map") %>%
      clearShapes() %>%
      addPolygons(
        data        = sf_obj,
        fillColor   = ~pal(sf_obj[[col_name]]),
        fillOpacity = 0.8,
        color       = "white",
        weight      = 0.3,
        opacity     = 0.5,
        layerId     = as.character(seq_len(nrow(sf_obj))),
        label       = ~paste0(catchment_name, " | ", taso4_osat),
        highlightOptions = highlightOptions(
          color       = "#e74c3c",
          weight      = 2,
          fillOpacity = 0.95,
          bringToFront = TRUE
        )
      ) %>%
      addLegend(
        position = "bottomright",
        pal      = pal,
        values   = vals,
        title    = "m³/s",
        opacity  = 0.85,
        layerId  = "legend"
      )
  })

  # Capture click
  observeEvent(input$map_shape_click, {
    click <- input$map_shape_click
    if (!is.null(click$id)) {
      selected_idx(as.integer(click$id))
    }
  })

  # Highlight selected polygon
  observeEvent(selected_idx(), {
    idx <- selected_idx()
    if (is.null(idx)) return()
    sf_obj <- current_wa()
    sel    <- sf_obj[idx, ]
    leafletProxy("map") %>%
      removeShape("selected_outline") %>%
      addPolygons(
        data    = sel,
        fill    = FALSE,
        color   = "#e74c3c",
        weight  = 2.5,
        opacity = 1,
        layerId = "selected_outline"
      )
  })

  # -----------------------------------------------------------------------------
  # Selected info panel
  # -----------------------------------------------------------------------------
  output$selected_info <- renderUI({
    idx <- selected_idx()
    if (is.null(idx)) return(p("Click a subcatchment on the map", style = "color:grey"))
    sf_obj   <- current_wa()
    row      <- sf_obj[idx, ]
    col_name <- paste0(input$season, "_", input$stat)
    val      <- round(as.numeric(row[[col_name]]), 4)
    tagList(
      p(strong("Catchment: "), row$catchment_name),
      p(strong("Subcatchment ID: "), row$taso4_osat),
      p(strong(paste0(season_labels[input$season], " ",
                      stat_labels[input$stat], ":")),
        span(paste0(val, " m³/s"), class = "metric-val"))
    )
  })

  # -----------------------------------------------------------------------------
  # Interpretation
  # -----------------------------------------------------------------------------
  output$interpretation <- renderUI({
    idx <- selected_idx()
    if (is.null(idx)) return(p("Select a subcatchment to see interpretation.",
                               style = "color:grey"))
    sf_obj   <- current_wa()
    row      <- sf_obj[idx, ]
    col_name <- paste0(input$season, "_", input$stat)
    val      <- as.numeric(row[[col_name]])
    text     <- interpret(row$catchment_name, row$taso4_osat,
                          input$scenario, input$stat, input$season, val)
    p(text)
  })

  # -----------------------------------------------------------------------------
  # Seasonal statistics table
  # -----------------------------------------------------------------------------
  output$stats_table <- renderTable({
    idx <- selected_idx()
    if (is.null(idx)) return(data.frame(Note = "Click a subcatchment"))
    sf_obj <- current_wa()
    row    <- sf_obj[idx, ]
    do.call(rbind, lapply(seasons, function(s) {
      data.frame(
        Season  = season_labels[s],
        Min     = round(as.numeric(row[[paste0(s, "_min")]]),    4),
        Q10     = round(as.numeric(row[[paste0(s, "_q10")]]),    4),
        Median  = round(as.numeric(row[[paste0(s, "_median")]]), 4),
        Mean    = round(as.numeric(row[[paste0(s, "_mean")]]),   4),
        Max     = round(as.numeric(row[[paste0(s, "_max")]]),    4),
        stringsAsFactors = FALSE
      )
    }))
  }, digits = 4)

  # -----------------------------------------------------------------------------
  # Seasonal bar chart
  # -----------------------------------------------------------------------------
  output$stats_bar <- renderPlot({
    idx <- selected_idx()
    if (is.null(idx)) return()
    sf_obj   <- current_wa()
    row      <- sf_obj[idx, ]
    col_name <- paste0(seasons, "_", input$stat)
    vals     <- sapply(col_name, function(cn) as.numeric(row[[cn]]))
    names(vals) <- c("Win", "Spr", "Sum", "Aut", "Ann")

    par(mar = c(3, 4, 1.5, 0.5), bg = "white")
    bp <- barplot(vals,
                  col    = c("#6baed6", "#74c476", "#fd8d3c", "#e6550d", "#9ecae1"),
                  border = NA,
                  ylab   = expression(m^3~s^{-1}),
                  main   = "",
                  cex.axis = 0.85,
                  cex.names = 0.85,
                  las  = 1)
    title(main = paste0(stat_labels[input$stat], " by season"),
          cex.main = 0.85, line = 0.3)
  })

  # -----------------------------------------------------------------------------
  # Hydrograph — nearest gauge
  # -----------------------------------------------------------------------------

  # Find nearest gauge to selected subcatchment
  nearest_gauge <- reactive({
    idx <- selected_idx()
    if (is.null(idx)) return(NULL)

    sf_obj         <- current_wa()
    sel_centroid   <- st_centroid(sf_obj[idx, ])
    catch_name     <- sf_obj$catchment_name[idx]

    # Load discharge stations for this catchment
    stations_path <- file.path(results_dir, "model_setups/catchments",
                               catch_name, "catch_data", "disch_stations.gpkg")
    if (!file.exists(stations_path)) return(NULL)

    stations <- st_read(stations_path, quiet = TRUE)
    if (nrow(stations) == 0) return(NULL)
    stations <- st_transform(stations, 4326)

    # Find nearest
    dists   <- st_distance(sel_centroid, stations)
    nearest <- which.min(dists)

    list(
      catch_name = catch_name,
      station    = stations[nearest, ]
    )
  })

  output$gauge_info <- renderUI({
    ng <- nearest_gauge()
    if (is.null(ng)) return(p("No gauge data available", style = "color:grey"))
    p(strong("Catchment: "), ng$catch_name)
  })

  output$hydrograph <- renderPlot({
    ng <- nearest_gauge()
    if (is.null(ng)) return()

    df <- discharge[[ng$catch_name]]
    if (is.null(df)) return()

    # Find obs/sim columns for this catchment
    obs_cols <- grep("^X[0-9]", names(df), value = TRUE)
    sim_cols <- grep("^simulated_", names(df), value = TRUE)
    if (length(obs_cols) == 0) return()

    # Use first gauge pair
    obs <- df[[obs_cols[1]]]
    sim <- df[[sim_cols[1]]]

    # Filter to 2019-2023
    mask  <- df$Date >= as.Date("2019-01-01") & df$Date <= as.Date("2023-12-31")
    dates <- df$Date[mask]
    obs   <- obs[mask]
    sim   <- sim[mask]

    y_max <- max(c(obs, sim), na.rm = TRUE) * 1.15

    par(mar = c(3, 4, 1.5, 0.5), bg = "white")
    plot(dates, obs, type = "n",
         ylim = c(0, y_max),
         xlab = "", ylab = expression(Q~(m^3~s^{-1})),
         cex.axis = 0.80, cex.lab = 0.85, las = 1)

    # Shaded periods
    rect(as.Date("2020-01-01"), -1, as.Date("2022-12-31"), y_max * 10,
         col = "#d5e8d4", border = NA)
    rect(as.Date("2023-01-01"), -1, as.Date("2023-12-31"), y_max * 10,
         col = "#dae8fc", border = NA)

    lines(dates, sim, col = "#e74c3c", lwd = 1.1)
    lines(dates, obs, col = "#2c3e50", lwd = 1.3)

    # X axis years
    axis(1, at = seq(as.Date("2019-01-01"), as.Date("2024-01-01"), by = "year"),
         labels = 2019:2024, cex.axis = 0.80)

    legend("topright",
           legend = c("Observed", "Simulated"),
           lty    = c(1, 1), lwd = c(1.3, 1.1),
           col    = c("#2c3e50", "#e74c3c"),
           cex    = 0.72, bty = "n")

    # Pull calibration metrics for annotation
    station_id <- sub("^X", "", obs_cols[1])
    m_cal <- metrics[metrics$station_id == station_id &
                     metrics$period == "calibration", ]
    if (nrow(m_cal) > 0) {
      mtext(sprintf("Calibration: NSE=%.2f  KGE=%.2f  PBIAS=%.1f%%",
                    m_cal$NSE[1], m_cal$KGE[1], m_cal$PBIAS[1]),
            side = 3, line = 0.2, cex = 0.68, col = "grey30")
    }

    box(col = "grey70")
  })
}

# -----------------------------------------------------------------------------
# Run
# -----------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
