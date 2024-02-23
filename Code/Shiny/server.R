#### Server
# The script to setup the application's server.


### Server ----
server <- function(input, output) {
  ## Computations
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
        dt           = dt_HeroStats,
        lvl          = input$in_LVL,
        hero_player  = input$in_HeroPlayer, 
        hero_enemy   = input$in_EnemyPlayer,
        stats        = c_CompStats,
        color_player = c_ColorPlayerNew()
      )
    }
  )
  # Stat over time
  output$out_StatOverTime <- renderPlotly(
    expr = {
      f_PlotStatOverTime(
        dt           = dt_HeroStats,
        stat         = c_StatNew(), 
        hero_player  = input$in_HeroPlayer, 
        hero_enemy   = input$in_EnemyPlayer,
        color_player = c_ColorPlayerNew()
      )
    }
  )
  # Stat distribution
  output$out_StatDist <- renderPlotly(
    expr = {
      f_PlotStatDist(
        dt           = dt_HeroStats,
        lvl          = input$in_LVL,
        stat         = c_StatNew(),
        hero_player  = input$in_HeroPlayer,
        hero_enemy   = input$in_EnemyPlayer,
        color_player = c_ColorPlayerNew()
      )
    }
  )
}