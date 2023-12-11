function(input, output){
    
    output$text_selections = renderText({
        paste0("You have selected ", input$year,
               " and ", input$selected_outcome
        )
    })
    
    output$output_table = renderTable({
        
        data_year = datasets[[input$year]]
        
        out = data_year %>% 
            filter(Health_Indicator_Desc == input$selected_outcome) %>%
            select(Publication_Year, Health_Indicator_Desc,
                   County, Numerator_Total, Denominator_Total,
                   Rate.Percentage, Age.Adjusted_Rate)
        
        return(out)
    })
}