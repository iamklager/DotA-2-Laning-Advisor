#### Main
# The main script used to run the application.


### Clearing environment ----
setwd(gsub("Code$", "", dirname(rstudioapi::getActiveDocumentContext()$path)))
rm(list = ls())
cat("\14")


### General project setup ----
source("Code/General Project Setup/libraries.R")
source("Code/General Project Setup/input_constants.R")
source("Code/General Project Setup/functions_visual.R")


### Data stuff ----
source("Code/Data Stuff/data_import.R")
source("Code/Data Stuff/data_processing.R")


### Shiny ----
source("Code/Shiny/ui.R")
source("Code/Shiny/server.R")


### Running the app ----
shinyApp(ui, server)
