# Creating Web Applications with R-Shiny Workshop

Hello and welcome to my workshop for the Population Dynamics and Health Program at the University of Michigan

Here is a rough outline of my planned schedule for the day. All times E.S.T.

1. Introduction: 9:00 - 9:15
2. Basic Pieces of App: 9:15 - 9:30
3. Building an App: 9:30 - 10:30
4. Break: 10:30 - 10:45
5. Building an App II: 1045 - 1115
6. Hosting: 1115 - 1130
7. Accessibility: 1130 - 1145
8. Break: 1145 - 12
9. A Tour of Advanced Features: 12-1pm

We will be utilizing [RStudio](https://posit.co/products/open-source/rstudio/) and a number of different R packages in this workshop.  You can utilzie the following R code to install these packages.

```{R}
packages_to_install = c(
    "shiny",
    "dplyr",
    "ggplot2",
    "plotly",
    "DT",
    "shinyWidgets",
    "shinythemes",
    "htmltools",
    "leaflet",
    "sf",
    "tigris"
)

#to install all of these
lapply(packages_to_install,  install.packages)
```
