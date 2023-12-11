fluidPage(title = "California County Rankings",
    sidebarPanel(
        selectInput(
            inputId = "year",
            label = "Select a year",
            choices = c("2021","2022","2023"),
            multiple = FALSE
        ),
        selectInput(
            inputId = "selected_outcome",
            label = "Choose an Outcome",
            choices = c("Deaths Due to All Causes", 
                        "Deaths Due to All Cancers",
                        "Deaths Due to Colorectal Cancer"
            ),
            selected = "Deaths Due to All Causes",
            multiple = FALSE
        ),
        textOutput("text_selections")
    ),
    mainPanel(
        tableOutput("output_table")
    )
)