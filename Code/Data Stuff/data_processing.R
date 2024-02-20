#### Data processing
# All data processing that is done before the shiny application is started.


### Data formats ----
dt_HeroStats <- as.data.table(dt_HeroStats)
dt_Dic <- as.data.table(dt_Dic)


### Selectable stats ----
c_SelectableStats <- dt_Dic[
  !Abbreviation %in% names(which(sapply(dt_HeroStats, class) != "numeric")), 
  FullName
]




