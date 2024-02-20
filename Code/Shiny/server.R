#### Server
# The script to setup the application's server.


### Server ----
server <- function(input, output) {
  ## Computations
  # Updating hero stats based on level
  dt_HeroStatsNew <- reactive({
    f_CalcStats(dt = dt_HeroStats, lvl = input$in_LVL)
  })
  # Matching stat to column name
  c_StatNew <- reactive({
    dt_Dic[FullName == input$in_Stat, Abbreviation]
  })
  
  ## Visuals
  # Stat distribution
  output$out_StatDist <- renderPlot(
    expr = {
      f_PlotStatDist(
        dt          = dt_HeroStatsNew(),
        stat        = c_StatNew(),
        hero_player = input$in_HeroPlayer,
        hero_enemy  = input$in_EnemyPlayer
      )
    }
  )
}