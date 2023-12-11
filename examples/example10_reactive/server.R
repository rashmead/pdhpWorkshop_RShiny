function(input, output){
    
    data_sub = reactive({
        datasets[[input$year]] %>% 
            filter(Health_Indicator_Desc == input$selected_outcome)
    })    
    
    all_cali_ref_rate = reactive({ 
        data_sub() %>% 
            filter(County == "CALIFORNIA") %>%
            pull(Rate.Percentage)
    })
    
    data_sub_nocali = reactive({
        data_sub() %>% 
            filter(County != "CALIFORNIA")
    })
    
    plot_title = reactive({
        paste0("Rate of ", input$selected_outcome, " in ", input$year) 
    })
    
    output$text_selections = renderText({
        paste0("You have selected ", input$year,
               " and ", input$selected_outcome
        )
    })
    
    output$output_table = renderTable({
        
        out = data_sub_nocali() %>%
            select(Publication_Year, Health_Indicator_Desc,
                   County, Numerator_Total, Denominator_Total,
                   Rate.Percentage, Age.Adjusted_Rate)
        
        return(out)
    })
    
    output$output_plot = renderPlot({
        
        out =  plotCountyPoints(data = data_sub_nocali(),
                                 reference = all_cali_ref_rate(), 
                                 rate_variable = "Rate.Percentage", 
                                 use_reference_line = input$use_cali_reference,
                                 title = plot_title())
        
        return(out)
    })
    
    
}