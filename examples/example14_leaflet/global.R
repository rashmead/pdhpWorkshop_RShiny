library(dplyr)
library(ggplot2)
library(shinyWidgets)
library(DT)
library(plotly)
library(leaflet)

cal_county_rankings_2023 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/2d1417bc-f703-4977-8d58-ae1a0caf0be8/download/chsp2023_odp_20230221.csv")

cal_county_rankings_2022 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/9a60e446-cdc2-4413-97a9-1a686f3887c3/download/chsp_2022_odp_2022-04-08.csv")

cal_county_rankings_2021 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/3781a514-d658-4779-abb5-3c71e15c1944/download/chsp_2021_odp_2021-04-08.csv")

datasets = list( "2023" = cal_county_rankings_2023,
                 "2022" = cal_county_rankings_2022,
                 "2021" = cal_county_rankings_2021)

data_all_years = bind_rows(cal_county_rankings_2021, cal_county_rankings_2022, cal_county_rankings_2023)

cal_counties_geo = tigris::counties(state = "06", year = "2023") %>%
    sf::st_transform('+proj=longlat +datum=WGS84')

county_list = data_all_years %>% distinct(County) %>% arrange(County) %>% pull(County)

plotCountyPoints = function(data, reference,
                            rate_variable = "Rate.Percentage",
                            use_reference_line = TRUE, title = "title", alt_title = "alt_title"){
    
    out_plot = ggplot(data, aes(y=County, x=.data[[rate_variable]])) +
        geom_point() + 
        ggtitle(title) + 
        labs(alt = alt_title)
        
    
    if(use_reference_line){
        out_plot = out_plot + geom_vline(xintercept = reference,
                                         linetype="dotted", 
                                         color = "blue")     
    }
    
    return(out_plot)
}


plotCountyPointsPlotly = function(data, title = ""){
    
    levels = data %>% distinct(County) %>% pull(County)
    n_levels = length(levels)

    
    
    fig =  plot_ly(data %>% filter(County == levels[1]), x = ~Publication_Year, y = ~Rate.Percentage, type = 'scatter',
                   mode = "lines+markers", name = levels[1],
                   hovertemplate = paste0("<b>Year:</b> %{x}<br>",
                                          "<b>County:</b>",levels[1],"<br>",
                                          "<b>Rate</b>: %{y}",
                                          "<extra></extra>")) %>%
            layout(xaxis = list(type = "date", tickformat = "%Y"))
    
    if(n_levels > 1){
        for(i in 2:n_levels){
            fig = fig %>% add_trace(data = data %>% filter(County == levels[i]), x = ~Publication_Year, 
                           y = ~Rate.Percentage, type = 'scatter',
                           mode = "lines+markers", name = levels[i],
                           hovertemplate = paste0("<b>Year:</b> %{x}<br>",
                                                  "<b>County:</b>",levels[i],"<br>",
                                                  "<b>Rate</b>: %{y}",
                                                  "<extra></extra>"))    
        }
    }
    
    fig = fig %>%  layout(title = title,
                          xaxis = list(title = "Year" ),
                          yaxis = list(title = "Unadjusted Rate")
                    )
    
    return(fig)
}


makeleafletMap = function(data, cal_counties_geo, var = "Rate.Percentage"){
    
    #join the measures with the geographic table
    cal_counties_w_variable = cal_counties_geo %>% 
        left_join(data, by = c("NAME" = "County")) %>%
        rename(map_var = .data[[var]])
    
    colors_for_palette = c("#EBF6FF","#6BAED6", "#08306B")
    pal = colorNumeric(colors_for_palette, domain = cal_counties_w_variable$map_var, na.color = "#f1f1e0")
    
    #make hover
    if(var == "Rate.Percentage"){
        var_label = "Unadjusted Rate"
    }else{
        var_label = "Age-adjusted Rate"
    }
    
    hover_text = paste0(
        "<b>",cal_counties_w_variable$NAME,"</b><br>",
        var_label,": ", cal_counties_w_variable$map_var)
    
    cal_counties_w_variable$hover_text = lapply(hover_text, function(x) shiny::HTML(x))
    
    map_continous_scale = leaflet(width = 1250, height = 800,   
                                  options = leafletOptions(zoomControl = FALSE,
                                                           minZoom = 5.7,
                                                           maxZoom = 5.7,
                                                           dragging = FALSE)) %>%
        addProviderTiles(providers$Esri.WorldGrayCanvas) %>% #this is a more plain tile layer
        addPolygons(data = cal_counties_w_variable,
                    color = "black", #controls the color of the shape boundaries
                    weight = 2, #conrtrols the thickness of the shape boundaries
                    fillOpacity = 1, #controls the opacity of the fill color
                    fillColor = ~pal(map_var),
                    label = ~hover_text)     #NAME is a variable in our shapefile
    
    
    map_continous_scale %>%
        addLegend("bottomright",
                  pal = pal,
                  values = cal_counties_w_variable$map_var,
                  na.label = paste("N/A"),
                  opacity = 1)
}


