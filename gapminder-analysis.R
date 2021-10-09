## gapminder-analysis.R
## analysis with gapminder data
## J Lowndes lowndes@nceas.ucsb.edu
## re-written by Novi susetyo adi

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

## plot 2
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
ggsave(filename = "Afghanistan.png", plot = my_plot)

## New Method : "for loop" step 1
## create country variable
cntry <- "Afghanistan"

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == cntry)

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste(cntry, "GDP per capita", sep = " "))

## note: there are many ways to create filenames with paste() or file.path(); we are doing this way for a reason.
ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)

## New Method : "for loop" step 2

## create country variable
cntry <- "Afghanistan"

## create a list of countries
country_list <- c("Albania", "Finland", "Spain")

for ( cntry in country_list ) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
  
}

## 8.4.3. Executable 'for loop'

## simple version

## create a list of countries
country_list <- c("Albania", "Finland", "Spain")

for ( cntry in country_list ) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
  
}

## final version

dir.create("figures") 

## create a list of countries
country_list <- unique(gapminder$country) # ?unique() returns the unique values

for( cntry in country_list ){
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## add the figures/ folder
  ggsave(filename = paste("figures/", cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
} 

## Practice using countries in europe only, steps :
## 1. loops through countries in Europe only
## 2. plots the cumulative mean gdpPercap
## 3. saves them to a new subfolder inside the (recreated) figures folder called “Europe”

## create folder
## dir.create("figures/europe")

## create a list of countries. Calculations go here, not in the for loop
## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/europe/", cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
} 

# 8.5.1 if statement basic structure

# Important !!
# if
# if (condition is true) {
#  do something
#}

# if ... else
#if (condition is true) {
#  do something
#c} else {  # that is, if the condition is false,
#  do something different
#}

# I. The wrong one
est <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- left_join(gapminder, est)

#dir.create("figures") 
#dir.create("figures/Europe") 

## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_europe$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (gap_to_plot$estimated == "yes") {
    
    ## add a print statement just to check
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  }
  #   Warning message:
  # In if (gap_to_plot$estimated == "yes") { :
  #   the condition has length > 1 and only the first element will be used
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 

# II. The correct one 1

## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_europe$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 

# III. The correct one 2

## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_europe$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else {
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 

# IV. The correct one 3

## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_europe$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else if (any(gap_to_plot$estimated == "no")) {
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 

# IV. My Own Practice 1 : Asia

#dir.create("figures/Asia")

## create a list of countries
gap_asia <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Asia") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_asia$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot_asia <- gap_asia %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot_asia <- ggplot(data = gap_to_plot_asia, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot_asia$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot_asia <- my_plot_asia +
      labs(subtitle = "Estimated data")
  } else if (any(gap_to_plot_asia$estimated == "no")) {
    
    my_plot_asia <- my_plot_asia +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/Asia/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot_asia)
  
} 

# V. My Own Practice 1 : America

dir.create("figures/America")

## create a list of countries
gap_america <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Americas") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))

country_list <- unique(gap_america$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot_america <- gap_america %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot_america <- ggplot(data = gap_to_plot_america, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot_asia$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot_america <- my_plot_america +
      labs(subtitle = "Estimated data")
  } else if (any(gap_to_plot_america$estimated == "no")) {
    
    my_plot_america <- my_plot_america +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/America/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot_america)
  
}