

## talk about .Rproj and computer organization

## tidyverse 
#install.packages("tidyverse")
library(tidyverse)
#install.packages("Lahman")
library(Lahman)
#install.packages("lubridate")
library(lubridate)
#install.packages("palmerpenguins")
library(palmerpenguins)
#install.packages("ggridges") 
library(ggridges)

## tibble
as_tibble(Batting)
as_tibble(People)

## dplyr 

### select

### filter 

### arrange 

### mutate 

### group_by/summarize 

### left_join 

### pipe operator

## readr


## examples 

### career home runs (arranged from high to low; add final game)

### career batting average (since 1947; minimum 3000 AB)


## ggplot2 

### career home runs by final year 


### career batting average since 1947 by final year 


### career home runs vs era-adjusted home runs by final game


### single season HR by position 1982-1993 (minimum 100 AB)

#### Notes: 
Fielding_small = Fielding %>% 
  select(playerID, yearID, POS, InnOuts) %>% 
  group_by(playerID, yearID) %>% 
  filter(InnOuts == max(InnOuts)) %>% 
  filter(POS != "P", !is.na(POS)) %>% 
  rename("primaryPOS" = POS) %>% 
  select(playerID, yearID, primaryPOS)

Batting %>% 
  filter(yearID >= 1982, yearID <= 1993, AB >= 100) %>% 
  select(playerID, yearID, HR, AB) %>% 
  left_join(Fielding_small) %>% 
  ggplot() + 
  aes(x = HR, y = primaryPOS, fill = primaryPOS) + 
  geom_density_ridges() 

## https://daviddalpiaz.org/posts/moneyball-in-r/

