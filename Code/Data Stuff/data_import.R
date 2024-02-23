#### Data import
# Importing all necessary data.


### Hero stats ----
dt_HeroStats <- readxl::read_xlsx("Data/hero_stats.xlsx", sheet = c_Patch)



### Dictionary ----
dt_Dic <- readxl::read_xlsx(paste0("Data/dictionary.xlsx"))
