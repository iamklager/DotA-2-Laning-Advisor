#### Data processing
# All data processing that is done before the shiny application is started.


### Data formats ----
dt_HeroStats <- as.data.table(dt_HeroStats)
dt_Dic <- as.data.table(dt_Dic)


### Selectable stats ----
c_UnselectableStats <- c(
  names(which(sapply(dt_HeroStats, class) != "numeric")),
  colnames(dt_HeroStats)[grepl("_b", colnames(dt_HeroStats))],
  colnames(dt_HeroStats)[grepl("_g", colnames(dt_HeroStats))],
  "LVL", "DmgBlk_prob", "DmgBlk_dmg", "ASM", "DMG_main"
)
c_SelectableStats <- sort(dt_Dic[!Abbreviation %in% c_UnselectableStats, FullName])




