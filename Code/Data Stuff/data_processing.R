#### Data processing
# All data processing that is done before the shiny application is started.


### Data formats ----
dt_HeroStats <- as.data.table(dt_HeroStats)
dt_Dic <- as.data.table(dt_Dic)


### Selectable stats ----
c_SelectableStats <- sort(dt_Dic[!Abbreviation %in% c_UnselectableStats, FullName])

### Selectable heroes ----
c_SelectableHeroes <- dt_HeroStats$Name

### Stat calculations ----
## Level
dt_HeroStats <- dt_HeroStats[rep(1:nrow(dt_HeroStats), n_LVLRange[length(n_LVLRange)])]
dt_HeroStats[, LVL := sort(rep(n_LVLRange, nrow(dt_HeroStats)/n_LVLRange[length(n_LVLRange)]))]

## Attributes
dt_HeroStats[, STR := round(STR_b + (LVL-1)*STR_g) ]
dt_HeroStats[, AGI := round(AGI_b + (LVL-1)*AGI_g) ]
dt_HeroStats[, INT := round(INT_b + (LVL-1)*INT_g) ]

## Attack
dt_HeroStats[, AS := (AS_b + AGI)*(1 + ASM)]
dt_HeroStats[, AS := ifelse(AS < 20, 20, AS)]
dt_HeroStats[, AS := round(ifelse(AS > 700, 700, AS))]
dt_HeroStats[, AtkRt := round(AS/(100*AtkT_b), 4)]
dt_HeroStats[, AtkRng := round(AtkRng_b)]
dt_HeroStats[, DMG_avg_b := (DMG_min_b + DMG_max_b)/2]
dt_HeroStats$DMG_main <- apply(dt_HeroStats, 1, function(x) {
  y <- unlist(x)
  ifelse(
    y["A"] == "Universal", 
    0.7*sum(as.numeric(y[c("STR", "AGI", "INT")])), 
    as.numeric(y[which(names(y) == y["A"])]) 
  ) 
})
dt_HeroStats[, DMG_min := round(DMG_min_b + DMG_main)]
dt_HeroStats[, DMG_max := round(DMG_max_b + DMG_main)]
dt_HeroStats[, DMG_avg := round((DMG_min + DMG_max)/2)]

## Survivability
dt_HeroStats[, HP := round(HP_b + 22*(STR_b + (LVL-1)*STR_g)) ]
dt_HeroStats[, HP_s := round(HP_s_b + (0.1*STR), 2) ]
dt_HeroStats[, MagRes := round(MagRes_b + (INT/10)*0.01, 4) ]
dt_HeroStats[, SlwRes := round(SlwRes_b, 4) ]
dt_HeroStats[, StsRes := round(StsRes_b, 4) ]
dt_HeroStats[, ARM := round(ARM_b + (AGI*0.167)) ]

# Utility
dt_HeroStats[, MP := round(MP_b + (12*INT))]
dt_HeroStats[, MP_s := round(MP_s_b + 0.05*INT, 2)]
dt_HeroStats[, MS := round(MS_b)]

