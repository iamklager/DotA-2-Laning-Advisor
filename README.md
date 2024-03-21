# DotA-2-Laning-Advisor
A simple dashboard helping you to better understand early-level lane matchups in DotA 2. Built in R using Shiny.

## Idea

This tool is aimed at providing the user with a simple way to analyze early-level hero (lane) matchups based on the heroe's stats.  
Note that neither items nor spells are being taken into account.

## Requirements

To run this project the user must have installed R in combination with the following libraries:
- *data.table*
- *readxl*
- *plotly*
- *shiny*
- *shinydashboard*
- *shinyWidgets*

## How to use

In the left part of the UI select the two heroes you want to compare, the level at which the comparison should happen, and the stat you are interested in. Additionally, you can check the *Color Blind Mode* checkmark to change the color for your hero from green to blue.  

The dashboard will display three plots to you. The first plot presents a comparison of the (in my opinion) most important stats between the selected heroes at the selected level. The second plot shows the comparison of a single stat between the selected heroes across the levels one to five. The third and last plot compares the selected stat at the selected level across all heroes. The two selected heroes are colored differently.  

Last, the patch for which this dashboard holds is shown in the top left of the UI.

Each chart is interactive and hovering over a given element will display its exact value.


## FAQ

### Why don't you host the tool online?

Besides giving myself a more fun and easier way to study hero matchups, this tool is just a fun personal project to make myself more familiar with the *data.table* and *plotly* libraries. While I am all for supporting the community (and hence publishing this project on GitHub) it was never this project's primary focus.

### Why are spells and items not being considered?

The reason I did not include spells and items in the dashboard is twofold. First, their effects' impact cannot be easily compared and quantified as easily as base stats if at all. Second, while base stats are static spells and items are leveled and bought in different orders, therefore increasing the possible scenarios. Managing these scenarios to allow a simplified comparison between heroes was simply out of scope for this project.  
In short, they add too much variation.

### Why are only the first five levels considered?

Following the previous answer, in my opinion, the game changes disproportionate as soon as heroes reach level six and gain their ultimate. This adds too much unpredictability for this simple dashboard to make sense. Additionally, once heroes reach level six the trading focused early laning stage for which this tool is meant has probably ended.

### How does the tool update its information after a patch?

Despite being an unreliable and tedious way of updating after a new patch all the information the tool uses is stored in the .xlsx-files found in the *Data* folder. I am manually updating these with every new patch and update this repository accordingly.
