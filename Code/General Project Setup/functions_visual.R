#### Functions visual
# All custom functions used to generate visuals (i.e., charts).


### Hero Comparison ----
f_PlotHeroComp <- function(dt, hero_player, hero_enemy, stats = c_CompStats, color_player) {
  # Preparing the data table for plotting
  dt <- dt[Name %in% c(hero_player, hero_enemy), .SD, .SDcols = c("Name", stats)]
  dt[, Color := ifelse( Name == hero_player, color_player, c_ColorEnemy )]
  dt2 <- copy(dt)
  dt2[, 2:(ncol(dt2)-1) := lapply(.SD, function(x) { 
    if (max(x) != 0) { 
      x/max(x)
    } 
  } ), .SDcols = 2:(ncol(dt2) - 1)]
  dt  <- melt(dt,  id.vars = c("Name", "Color"), variable.name = "Stat", value.name = "Standard")
  dt2 <- melt(dt2, id.vars = c("Name", "Color"), variable.name = "Stat", value.name = "Scaled")
  dt <- merge.data.table(x = dt, y = dt2)
  colnames(dt)[1] <- dt_Dic[Abbreviation == "Name", FullName]
  dt$Stat <- unlist(lapply(dt$Stat, function(x) { dt_Dic[Abbreviation == x, FullName] }))
  
  # Plotting
  res <- plot_ly(
    data = dt,
    type = "bar",
    x = ~Stat,
    y = ~Scaled,
    color = ~Hero,
    colors = ~Color,
    marker = list(
      line = list(color = "#000000", width = 1)
    ),
    text = ~Standard,
    hovertemplate = "<b>%{x}:</b> %{text}"
  )
  res <- layout(
    p = res,
    barmode = "group",
    bargap = 0.4,
    margin = list(b = 100, t = 100, l = 50, r = 150),
    title = list(
      text = "Hero Comparison", font = list(family = "Arial", size = 26)
    ),
    xaxis = list(
      title = list(
        text = "Stat", font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 12), 
      fixedrange = TRUE
    ),
    yaxis = list(title = "", showticklabels = FALSE, fixedrange = TRUE)
  )
  res <- plotly::config(
    p = res,
    responsive = FALSE,
    displayModeBar = FALSE
  )
  res
}


### Stat over time ----
f_PlotStatOverTime <- function(stat, hero_player, hero_enemy, color_player) {
  # Preparing the data table for plotting
  dt <- dt_HeroStats[Name %in% c(hero_player, hero_enemy)]
  dt <- bind_rows(lapply(n_LVLRange, function(i) {
    f_CalcStats(dt, i)
  }))
  dt <- dt[, .SD, .SDcols = c("Name", stat, "LVL")]
  dt[, LVL := as.character(LVL)]
  plot_colors = c(color_player, c_ColorEnemy)
  plot_colors = setNames(plot_colors, c(hero_player, hero_enemy))
  
  # Plot
  res <- plot_ly(
    data          = dt,
    type          = "scatter", 
    mode          = "lines+markers",
    x             = ~LVL,
    y             = as.formula(paste0("~", stat)),
    color         = ~Name,
    colors        = plot_colors,
    linetype      = ~Name,
    line          = list(width = 2),
    marker        = list(size  = 8),
    text          = as.formula(paste0("~", stat)),
    hovertemplate = "<b>Level %{x}:</b> %{text}"
  )
  res <- layout(
    p = res,
    margin = list(b = 100, t = 100, l = 50, r = 150),
    title = list(
      text = dt_Dic[Abbreviation == stat, FullName], 
      font = list(family = "Arial", size = 26)
    ),
    xaxis = list(
      title = list(
        text = dt_Dic[Abbreviation == "LVL", FullName], font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 12), 
      fixedrange = TRUE
    ),
    yaxis = list(
      title = list(
        text = "", font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 12), 
      fixedrange = TRUE
    )
  )
  res <- plotly::config(
    p = res,
    responsive = FALSE,
    displayModeBar = FALSE
  )
  res
}


### Distribution of stat ----
f_PlotStatDist <- function(dt, stat, hero_player, hero_enemy, color_player) {
  # Preparing the data table for plotting
  dt[, Fill := "Other"]
  dt[Name == hero_player, Fill := hero_player]
  dt[Name == hero_enemy,  Fill := hero_enemy ]
  dt[, Alpha := 1]
  dt[Fill == "Other", Alpha := 0.3]
  plot_color <- c(color_player, c_ColorEnemy, "gray")
  plot_color <- setNames(plot_color, c(hero_player, hero_enemy, "Other"))
  
  # Plotting
  res <- plot_ly(
    data          = dt,
    type          = "bar",
    x             = ~Name,
    y             = as.formula(paste0("~", stat)),
    color         = ~Fill,
    colors        = plot_color,
    opacity       = ~Alpha,
    marker        = list( line = list(color = "#000000", width = 1) ),
    hovertemplate = "<b>%{x}:</b> %{y}"
  )
  res <- layout(
    p = res,
    margin = list(b = 100, t = 100, l = 50, r = 150),
    title = list(
      text = dt_Dic[Abbreviation == stat, FullName], font = list(family = "Arial", size = 26)
    ),
    xaxis = list(
      title = list(
        text = dt_Dic[Abbreviation == "Name", FullName], font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 10), 
      fixedrange = TRUE,
      categoryorder = "total ascending"
    ),
    yaxis = list(
      title = list(
        text = "", font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 12), 
      fixedrange = TRUE,
      ategoryorder = "total ascending"
    )
  )
  res <- plotly::config(
    p = res,
    responsive = FALSE,
    displayModeBar = FALSE
  )
  res
}

