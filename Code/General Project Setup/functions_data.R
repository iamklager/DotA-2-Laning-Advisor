#### Functions data
# All custom functions used to process data.


### Rounding function ----
f_RoundDT <- function(dt, cols) {
  dt <- copy(dt[,  (cols) := lapply(.SD, round), .SDcols = cols])
  return(dt)
}


### Function to calculate hero stats ----
f_CalcStats <- function(dt, lvl) {
  # Setting the initial level
  dt$LVL <- lvl
  
  # Attributes
  dt[, STR := STR_b + (LVL-1)*STR_g ]
  dt[, AGI := AGI_b + (LVL-1)*AGI_g ]
  dt[, INT := INT_b + (LVL-1)*INT_g ]
  dt <- f_RoundDT( dt, c("STR", "AGI", "INT") )
  
  # Attack
  dt[, AS := (AS_b + AGI)*(1 + ASM)]
  dt[, AS := ifelse(AS < 20, 20, AS)]
  dt[, AS := ifelse(AS > 700, 700, AS)]
  dt[, AtkRt := AS/(100*AtkT_b)]
  dt[, AtkRng := AtkRng_b]
  dt[, DMG_avg_b := (DMG_min_b + DMG_max_b)/2]
  dt$DMG_main <- apply(dt, 1, function(x) {
    y <- unlist(x)
    ifelse(
      y["A"] == "Universal", 
      0.7*sum(as.numeric(y[c("STR", "AGI", "INT")])), 
      as.numeric(y[which(names(y) == y["A"])]) 
    ) 
  })
  dt[, DMG_min := DMG_min_b + DMG_main]
  dt[, DMG_max := DMG_max_b + DMG_main]
  dt[, DMG_avg := (DMG_min + DMG_max)/2]
  dt <- f_RoundDT( dt, c("AS", "AtkRt", "DMG_min", "DMG_max", "DMG_avg") )
  
  # Survivability
  dt[, HP := HP_b + 22*(STR_b + (LVL-1)*STR_g) ]
  dt[, HP_s := HP_s_b + (0.1*STR) ]
  dt[, MagRes := MagRes_b + (INT/10)*0.01 ]
  dt[, SlwRes := SlwRes_b ]
  dt[, StsRes := StsRes_b ]
  dt[, ARM := ARM_b + (AGI*0.167) ]
  dt <- f_RoundDT( dt, c("HP", "MagRes", "SlwRes", "ARM") )
  
  # Utility
  dt[, MP := MP_b + (12*INT)]
  dt[, MP_s := MP_s_b + 0.05*INT]
  dt[, MS := MS_b]
  dt <- f_RoundDT( dt, c("MP"))
  
  return(dt)
}



