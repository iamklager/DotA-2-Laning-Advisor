# DotA-2-Laning-Advisor
A simple dashboard helping you to better understand early-level lane matchups in DotA 2. Built in R using Shiny.

## Idea

This tool is aimed at providing the user with a simple way to analyze early-level hero (lane) matchups based on the heroes' stats.  
Note that neither items nor spells are being taken into account.

## Demo
<p align = "center">
  <img src = "https://github.com/iamklager/DotA-2-Laning-Advisor/raw/main/.github/demo_1.png" width = "400" />
  <img src = "https://github.com/iamklager/DotA-2-Laning-Advisor/raw/main/.github/demo_2.png" width = "400" />
</p>

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

Additional settings can be adjusted in the *input_constants.R* script in the *Code/General Project Setup* folder. These include the selected patch, the most important stats displayed in the first chart, the stat selected by default, the range of possible levels, and the colors to use for your and the enemy hero.


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

### What about facets?

Facets added another layer of complexity to DotA and to be honest I did not expect such a drastic and complexity increasing update. Therefore, facets are not included in this dashboard for the same reasons as abilities, talents and items have been ignored. Sadly I must admit that this new increase of complexity also decreased the value of this tool.

