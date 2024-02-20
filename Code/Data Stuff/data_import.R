#### Data import
# Importing all necessary data.


### Hero stats ----
dt_HeroStats <- readxl::read_xlsx(paste0("Data/", c_Patch, ".xlsx"))



### Dictionary ----
dt_Dic <- readxl::read_xlsx(paste0("Data/dictionary.xlsx"))