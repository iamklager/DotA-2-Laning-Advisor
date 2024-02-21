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
    bargroupgap = 0.1,
    margin = list(b = 50, t = 50),
    title = list(
      text = "Hero Comparison", font = list(family = "Arial", size = 26)
    ),
    xaxis = list(
      title = list(
        text = "Stat", font = list(family = "Arial", size = 20)
      ), 
      tickfont  = list(family = "Arial", size = 16), 
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
  
  # Plotting
  ggplot(dt, aes(x = LVL, y = .data[[stat]], color = Name, linetype = Name)) + 
    geom_line(linewidth = 1) + geom_point(size = 2) + 
    theme_light(base_size = 16) + 
    theme(panel.grid.major = element_blank()) + 
    xlab(dt_Dic[Abbreviation == "Name", FullName]) + 
    ylab(dt_Dic[Abbreviation == stat, FullName]) + 
    scale_color_manual(
      name = "Hero",
      breaks = c(hero_player, hero_enemy),
      values = c(color_player, c_ColorEnemy)
    ) + 
    scale_linetype_manual(
      name = "Hero",
      breaks = c(hero_player, hero_enemy),
      values = c("solid", "dashed")[order(c(hero_player, hero_enemy))]
    )
  
}


### Distribution of stat ----
f_PlotStatDist <- function(dt, stat, hero_player, hero_enemy, color_player) {
  # Preparing the data table for plotting
  dt$Fill <- "Other"
  dt[Name == hero_player, Fill := hero_player]
  dt[Name == hero_enemy,  Fill := hero_enemy ]
  
  # Plotting
  ggplot(dt, aes(x = reorder(Name, + .data[[stat]]), y = .data[[stat]], fill = Fill, alpha = Fill)) + 
    geom_col(color = "#000000", width = 0.7) + theme_light(base_size = 16) + 
    theme(
      panel.grid.major = element_blank(), 
      axis.text.x = element_text(size = 8, angle = 90, hjust=0.95, vjust = 0.25)
    ) + 
    xlab(dt_Dic[Abbreviation == "Name", FullName]) + 
    ylab(dt_Dic[Abbreviation == stat, FullName]) + 
    scale_fill_manual(
      name = "Hero",
      breaks = c(hero_player, hero_enemy, "Other"),
      values = c(color_player, c_ColorEnemy, "gray")
    ) + 
    scale_alpha_manual(
      name = "Hero",
      breaks = c(hero_player, hero_enemy, "Other"),
      values = c(1, 1, 0.3)
    )
}

