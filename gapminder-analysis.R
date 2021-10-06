## gapminder-analysis.R
## analysis with gapminder data
## J Lowndes lowndes@nceas.ucsb.edu
## re-write by Novi susetyo adi

## load libraries
library (tidyverse)

## read in gapminder data
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv')

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")

## plot 1
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  labs(title = "Afghanistan")

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")

## plot 2
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
ggsave(filename = "Afghanistan_gdpPercap.png", plot = my_plot)
