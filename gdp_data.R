library(tidyverse)
gdp_data <- read.csv("datafile.csv")

gdp_share <- data.frame(gdp_data$Gross.Domestic.Product..in.Rs..Cr..at.2004.05,gdp_data$Agriculture...Allied.Services..in.Rs..Cr...at.2004.05.Prices,gdp_data$Agriculture..in.Rs..Cr...at.2004.05.Prices,gdp_data$Industry..in.Rs..Cr...at.2004.05.Prices,gdp_data$Mining.and.Quarrying..in.Rs..Cr...at.2004.05.Prices,gdp_data$Manufacturing..in.Rs..Cr...at.2004.05.Prices,gdp_data$Services..in.Rs..Cr...at.2004.05.Prices)
names(gdp_share) <- c("Total_GDP","Agriculture_allied_services","Agriculture","Industry","Mining_and_quarrying","Manufacturing","Services")
gdp_share <- gdp_share/gdp_share$Total_GDP
gdp_share <- subset(gdp_share,select = -Total_GDP)
gdp_share <- mutate(gdp_share,gdp_data$Financial.Year)
colnames(gdp_share)[colnames(gdp_share) == "gdp_data$Financial.Year"] <- "Financial_year"
