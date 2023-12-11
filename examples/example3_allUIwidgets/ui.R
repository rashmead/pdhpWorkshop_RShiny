
choices = c("Option A", "Option B", "Option C")

fluidPage(title = "Examples of Shiny Inputs",
    
    h2("Examples of Shiny Inputs"),      
          
    selectInput(
        inputId = "selectinput",
        label = "Select Input",
        choices = choices,
        selected = "Option A",
        multiple = FALSE
    ),
    
    radioButtons(
        inputId ="radioinput",
        label = "Radio Button Input",
        choices = choices,
        selected = NULL
    ),
    
    sliderInput(
        inputId = "slider",
        label = "Slider Input",
        min = 1,
        max = 10,
        value = 5
    ),
    
    numericInput(
        inputId ="numeric",
        label = "Numeric Input",
        value = 1000,
        min = 0, #minimum input value
        max = 10000 #maximum input value
    ),
    
    dateRangeInput(
        "daterange",
        "Date Range Input",
        start = "2023-07-30", #initial value
        end = "2023-08-05", #initial value
        min = NULL, #minimum allowed date
        max = NULL, #maximum allowed date
        format = "yyyy-mm-dd"
    ),
    
    dateInput(
        inputId ="date",
        label = "Date Input",
        min = NULL, #minimum allowed date
        max = NULL #maximum allowed date
    ),
    
    textInput(
        inputId ="textInput",
        label = "Text Input",
        value = "initial value!" #initial value
    ),
    
    checkboxInput(
        inputId = "checkbox",
        label = "Checkbox Input",
        value = FALSE #initial value
    )
    
    
)

