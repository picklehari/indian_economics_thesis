library(tidyverse)
library(reshape2)
library(ggplot2)

gdp_data <- read.csv("datafile.csv")
gdp_percent <-data.frame(gdp_data$Gross.Domestic.Product..in.Rs..Cr..at.2004.05,gdp_data$Agri.culture...Allied.Services..Share.to.Total.GDP,gdp_data$Agriculture...Share.to.Total.GDP ,gdp_data$Industry...Share.to.Total.GDP ,gdp_data$Mining.and.Quarrying...Share.to.Total.GDP,gdp_data$Manufacturing...Share.to.Total.GDP,gdp_data$Services...Share.to.Total.GDP)
names(gdp_percent) <- c("Total_GDP","Agriculture_allied_services","Agriculture","Industry","Mining_and_quarrying","Manufacturing","Services")
gdp_percent <- gdp_percent/gdp_percent$Total_GDP
gdp_percent <- subset(gdp_percent,select = - Total_GDP)
#gdp_percent <-mutate(gdp_percent,1-rowSums(gdp_percent))
#colnames(gdp_percent)[colnames(gdp_percent) == "1 - rowSums(gdp_percent)"] <- "Others"
gdp_percent <- mutate(gdp_percent,gdp_data$Financial.Year)
colnames(gdp_percent)[colnames(gdp_percent) == "gdp_data$Financial.Year"] <- "Financial_year"
plot_gdp <- melt(gdp_percent,id.vars="Financial_year")
colnames(plot_gdp)[colnames(plot_gdp)=="variable"] <-"Sector"
plot_gdp$value <- plot_gdp$value * 100
colnames(plot_gdp)[colnames(plot_gdp)=="value"] <- "Percentage_share"
#ggplot(plot_gdp, aes(x = Financial_year, y = Percentage_share)) + geom_line(aes(color = Sector,group = Sector))  # To plot Financial year vs value

gdp_growth <-data.frame(gdp_data$Financial.Year,gdp_data$Gross.Domestic.Product.....Growth.Rate..YoY.,gdp_data$Agriculture.....Growth.Rate..YoY.,gdp_data$Agriculture.....Growth.Rate..YoY.,gdp_data$Industry.....Growth.Rate..YoY.,gdp_data$Mining.and.Quarrying.....Growth.Rate..YoY.,gdp_data$Manufacturing.....Growth.Rate..YoY.,gdp_data$Services.....Growth.Rate..YoY.)
names(gdp_growth) <-c("Financial_year","Total_gdp","Agriculture","Agriculture_allied_services","Industry","Mining_and_quarrying","Manufacturing","Services")
plot_growth <- melt(gdp_growth,id.vars="Financial_year")

# Sector wise GDP growth per unit increase in Total GDP 
gdp_growth <-subset(gdp_growth,select = -Financial_year)
gdp_growth <-gdp_growth/gdp_growth$Total_gdp
gdp_growth <-mutate(gdp_growth,gdp_data$Financial.Year)
colnames(gdp_growth)[colnames(gdp_growth) == "gdp_data$Financial.Year" ] = "Financial_year"
gdp_growth <- subset(gdp_growth, select = -Total_gdp)
plot_growth <- melt(gdp_growth,id.vars="Financial_year")
colnames(plot_growth) <- c("Financial_year","Sector","Percentage_growth")
#ggplot(plot_growth,aes(x = Financial_year,y= Percentage_growth))+geom_line(aes(color = Sector,group = Sector))
gdp_agri_manufacturing <- subset(plot_growth,Sector == "Agriculture"|Sector == "Manufacturing")
