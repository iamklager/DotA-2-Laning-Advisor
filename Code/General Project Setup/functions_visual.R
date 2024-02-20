#### Functions visual
# All custom functions used to generate visuals (i.e., charts).


### Distribution of stat ----
f_PlotStatDist <- function(dt, stat, hero_player, hero_enemy) {
  # Preparing the data table for plotting
  dt$Fill <- "Other"
  dt[Name == hero_player, Fill := hero_player]
  dt[Name == hero_enemy,  Fill := hero_enemy ]
  
  # Plotting
  ggplot(dt, aes(x = reorder(Name, +.data[[stat]]), y = .data[[stat]], fill = Fill, alpha = Fill)) + 
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
      values = c(c_ColorPlayer, c_ColorEnemy, "gray")
    ) + 
    scale_alpha_manual(
      name = "Hero",
      breaks = c(hero_player, hero_enemy, "Other"),
      values = c(1, 1, 0.3)
    )
}

