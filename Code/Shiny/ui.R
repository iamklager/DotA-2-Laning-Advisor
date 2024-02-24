#### User interface
# The script to setup the application's user interface.


### Dashboard page ----
ui <- dashboardPage(
  ## Visuals
  skin = "blue",
  
  ## Dashboard header
  dashboardHeader(
    title = paste0("Laning Advisor - ", c_Patch)
  ),
  
  ## Dashboard sidebar
  dashboardSidebar(
    # Player hero selector
    selectInput(
      inputId = "in_HeroPlayer",
      label = "Your Hero",
      choices = c_SelectableHeroes,
      selected = c_SelectableHeroes[1]
    ),
    
    # Enemy hero selector
    selectInput(
      inputId = "in_EnemyPlayer",
      label = "Enemy Hero",
      choices = c_SelectableHeroes,
      selected = c_SelectableHeroes[2]
    ),
    
    # Level selector
    sliderInput(
      inputId = "in_LVL", 
      label = "Level", 
      min = n_LVLRange[1],
      max = n_LVLRange[length(n_LVLRange)],
      value = n_LVLRange[1],
      step = 1
    ),
    
    # Stat selector
    selectInput(
      inputId = "in_Stat",
      label = "Stat",
      choices = c_SelectableStats,
      selected = c_StartStat
    ),
    
    # Color blind mode switch
    checkboxInput(
      inputId = "in_ColorBlindMode",
      label = "Color Blind Mode",
      value = c_ColorBlindOnStart
    )
  ),
  
  ## Dashboard body
  dashboardBody(
    # Row 1
    fluidRow(
      plotlyOutput("out_HeroComp", height = "300px")
    ),
    
    # Row 2
    fluidRow(
      plotlyOutput("out_StatOverTime", height = "300px")
    ),
    
    # Row 3
    fluidRow(
      plotlyOutput("out_StatDist", height = "300px")
    )
    
  )
)
