navbarPage(title = "California County Rankings Dashboard",
           lang = "en-US",
           theme = shinythemes::shinytheme("spacelab"), 

    tabPanel("Welcome",
             fluidRow(
                 h1("2021-2023 California County Rankings Dashboard"),
                 h2("About the California County Rankings Dashboard"), 
                 p("County Health Status Profiles is an annually published report for the State of California by the California Department of Public Health in collaboration with the California Conference of Local Health Officers. Health indicators are measured for 58 counties and California statewide that can be directly compared to national standards and populations of similar composition. Where available, the measurements are ranked and compared with target rates established for Healthy People National Objectives."),
                 tags$br(),
                 tags$br(),
                 h2("Notes on Indicators"),
                 p("For tables where the health indicator denominator and numerator are derived from the same data source, the denominator excludes records for which the health indicator data is missing and unable to be imputed."),
                 tags$br(),
                 tags$br(),
                 h2("Data Availability"),
                 p("This data is available at",
                 tags$a(href ='https://data.chhs.ca.gov/dataset/county-health-status-profiles', "https://data.chhs.ca.gov/dataset/county-health-status-profiles")),
                 tags$br(),
                 tags$br(),
                 p("More information can be found",
                 tags$a(href ='https://www.cdph.ca.gov/Programs/CHSI/Pages/County-Health-Status-Profiles.aspx', "here.")
                 )
             ),
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
                 plotlyOutput("output_plotlyTable")
             ),
             fluidRow(
                 DTOutput("output_DTtable")
             )
    ),#end tabPanel
    tabPanel("Map",
             fluidRow(
                 sidebarPanel(width = 3,
                              selectInput(
                                  inputId = "year_map",
                                  label = "Select a year",
                                  choices = c("2021","2022","2023"),
                                  multiple = FALSE
                              ),
                              selectInput(
                                  "selected_outcome_map",
                                  label = "Choose an Outcome",
                                  choices = c("Deaths Due to All Causes", 
                                            "Deaths Due to All Cancers",
                                            "Deaths Due to Colorectal Cancer"
                                  ),
                                  selected = "Deaths Due to All Causes",
                                  multiple = FALSE
                              )
                 ),
                 mainPanel(width = 9,
                           leafletOutput("map",height = "500px")
                 )
             )

    )       
)