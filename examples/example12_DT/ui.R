navbarPage(title = "California County Rankings Dashboard",
           lang = "en-US",
           theme = shinythemes::shinytheme("spacelab"), 

    tabPanel("Welcome",
        p("Welcome to the R-Shiny California County Rankings Dashboard")
    ),           
           
    tabPanel("Compare Counties",       
           
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
            checkboxInput(
                "use_cali_reference",
                label = "Include California Reference Line?",
                value = TRUE
            ),
            textOutput("text_selections")
        ),
        mainPanel(
            plotOutput("output_plot")
        ),
        fluidRow(
            tableOutput("output_table")
        )
    ), #end tabPanel
    
    tabPanel("Counties Over Time",
             sidebarPanel(
                 selectInput(
                     inputId = "selected_outcome_time",
                     label = "Choose an Outcome",
                     choices = c("Deaths Due to All Causes", 
                                 "Deaths Due to All Cancers",
                                 "Deaths Due to Colorectal Cancer"
                     ),
                     selected = "Deaths Due to All Causes",
                     multiple = FALSE
                 ),
                pickerInput(
                    inputId = "county_selection",
                    label = "Choose one or more counties",
                    multiple = TRUE,
                    choices = county_list
                ) 
                 

             ),
             mainPanel(
                 
             ),
             fluidRow(
                 DTOutput("output_DTtable")
             )
    )#end tabPanel
             
)