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
  # Color blind mode
  c_ColorPlayerNew <- reactive({
    ifelse(input$in_ColorBlindMode, c_ColorPlayer[2], c_ColorPlayer[1])
  })
  
  ## Visuals
  # Hero comparison
  output$out_HeroComp <- renderPlotly(
    expr = {
      f_PlotHeroComp(
        dt           = dt_HeroStatsNew(),
        hero_player  = input$in_HeroPlayer, 
        hero_enemy   = input$in_EnemyPlayer,
        stats        = c_CompStats,
        color_player = c_ColorPlayerNew()
      )
    }
  )
  
  # Stat over time
  output$out_StatOverTime <- renderPlot(
    expr = {
      f_PlotStatOverTime(
        stat         = c_StatNew(), 
        hero_player  = input$in_HeroPlayer, 
        hero_enemy   = input$in_EnemyPlayer,
        color_player = c_ColorPlayerNew()
      )
    }
  )
  # Stat distribution
  output$out_StatDist <- renderPlot(
    expr = {
      f_PlotStatDist(
        dt           = dt_HeroStatsNew(),
        stat         = c_StatNew(),
        hero_player  = input$in_HeroPlayer,
        hero_enemy   = input$in_EnemyPlayer,
        color_player = c_ColorPlayerNew()
      )
    }
  )
}