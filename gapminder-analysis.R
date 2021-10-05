## gapminder-analysis.R
## analysis with gapminder data
## J Lowndes lowndes@nceas.ucsb.edu
## re-write by Novi susetyo adi

library (tidyverse)

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")
