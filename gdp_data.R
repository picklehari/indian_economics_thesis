library(tidyverse)
library(reshape2)
library(ggplot2)

gdp_data <- read.csv("datafile.csv")

gdp_test <- data.frame(gdp_data$Gross.Domestic.Product..in.Rs..Cr..at.2004.05,gdp_data$Agriculture...Allied.Services..in.Rs..Cr...at.2004.05.Prices,gdp_data$Agriculture..in.Rs..Cr...at.2004.05.Prices,gdp_data$Industry..in.Rs..Cr...at.2004.05.Prices,gdp_data$Mining.and.Quarrying..in.Rs..Cr...at.2004.05.Prices,gdp_data$Manufacturing..in.Rs..Cr...at.2004.05.Prices,gdp_data$Services..in.Rs..Cr...at.2004.05.Prices)
names(gdp_test) <- c("Total_GDP","Agriculture_allied_services","Agriculture","Industry","Mining_and_quarrying","Manufacturing","Services")
gdp_test <- gdp_test/gdp_test$Total_GDP
gdp_test <- subset(gdp_test,select = -Total_GDP)
gdp_test <- mutate(gdp_test,gdp_data$Financial.Year)
colnames(gdp_test)[colnames(gdp_test) == "gdp_data$Financial.Year"] <- "Financial_year"

gdp_share <-data.frame(gdp_data$Gross.Domestic.Product..in.Rs..Cr..at.2004.05,gdp_data$Agri.culture...Allied.Services..Share.to.Total.GDP,gdp_data$Agriculture...Share.to.Total.GDP ,gdp_data$Industry...Share.to.Total.GDP ,gdp_data$Mining.and.Quarrying...Share.to.Total.GDP,gdp_data$Manufacturing...Share.to.Total.GDP,gdp_data$Services...Share.to.Total.GDP)
names(gdp_share) <- c("Total_GDP","Agriculture_allied_services","Agriculture","Industry","Mining_and_quarrying","Manufacturing","Services")
gdp_share <- gdp_share/gdp_share$Total_GDP
gdp_share <- subset(gdp_share,select = - Total_GDP)
gdp_share <-mutate(gdp_share,1-rowSums(gdp_share))
colnames(gdp_share)[colnames(gdp_share) == "1 - rowSums(gdp_share)"] <- "Others"
gdp_share <- mutate(gdp_share,gdp_data$Financial.Year)
colnames(gdp_share)[colnames(gdp_share) == "gdp_data$Financial.Year"] <- "Financial_year"
plot_gdp <- melt(gdp_share,id.vars="Financial_year")
colnames(plot_gdp)[colnames(plot_gdp)=="variable"] <-"Department"
plot_gdp$value <- plot_gdp$value * 100
colnames(plot_gdp)[colnames(plot_gdp)=="value"] <- "Percentage_share"
ggplot(plot_gdp, aes(x = Financial_year, y = Percentage_share)) + geom_line(aes(color = Department,group = Department))  # To plot Financial year vs value
