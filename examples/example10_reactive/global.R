library(dplyr)
library(ggplot2)

cal_county_rankings_2023 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/2d1417bc-f703-4977-8d58-ae1a0caf0be8/download/chsp2023_odp_20230221.csv")

cal_county_rankings_2022 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/9a60e446-cdc2-4413-97a9-1a686f3887c3/download/chsp_2022_odp_2022-04-08.csv")

cal_county_rankings_2021 = read.csv("https://data.chhs.ca.gov/dataset/8ceba47b-6357-4946-9fb9-cbe8c02ca9ad/resource/3781a514-d658-4779-abb5-3c71e15c1944/download/chsp_2021_odp_2021-04-08.csv")

datasets = list( "2023" = cal_county_rankings_2023,
                 "2022" = cal_county_rankings_2022,
                 "2021" = cal_county_rankings_2021)


plotCountyPoints = function(data, reference,
                            rate_variable = "Rate.Percentage",
                            use_reference_line = TRUE, title = "title"){
    
    out_plot = ggplot(data, aes(y=County, x=.data[[rate_variable]])) +
        geom_point() + 
        ggtitle(title)
        
    
    if(use_reference_line){
        out_plot = out_plot + geom_vline(xintercept = reference,
                                         linetype="dotted", 
                                         color = "blue")     
    }
    
    return(out_plot)
}
