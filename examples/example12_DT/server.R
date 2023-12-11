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
    
    alt_plot_title = reactive({
        paste("A bar plot comparing the rate of ", input$selected_outcome, " in ", input$year,
              " by California county.")
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
                                 title = plot_title(),
                                 alt_title = alt_plot_title())
        
        return(out)
    })
    
    ###############
    ## Tab Counties Over Time
    ###############
    
    data_time= reactive({
        data_all_years %>% 
            filter(Health_Indicator_Desc == input$selected_outcome_time) %>%
            filter(County %in% input$county_selection)
    })   
    
    output$output_DTtable = renderDT({
        
        out = data_time() %>%
            select(Publication_Year, Health_Indicator_Desc,
                   County, Rate.Percentage, Age.Adjusted_Rate) %>%
            datatable(rownames = FALSE,
                      caption = "California County Health Rankings",
                      colnames = c("Year", "Indicator", "County", "Rate/Percentage",
                                   "Age-Adjusted Rate/Percentage"),
                      extensions = c('Buttons'),
                      options = list(
                          scrollX = TRUE,
                          scrollY = '500px',
                          paging=FALSE,
                          dom = 'Bfrtip',
                          buttons = c('csv', 'excel', 'pdf', 'print')
                      )
            )
        
        return(out)
    })
    
    
}