

## talk about .Rproj and computer organization

## tidyverse 
#install.packages("tidyverse")
library(tidyverse)
#install.packages("Lahman")
library(Lahman)
#install.packages("ggridges") 
library(ggridges)

## tibble
Batting = as_tibble(Batting)
People = as_tibble(People)

## dplyr 

### select
select(Batting, c(H, HR))
Batting %>% select(H, HR)

### filter 
Batting %>% filter(yearID >= 1947)

### arrange 
Batting %>% arrange(desc(HR))

### mutate 
Batting %>% filter(AB >= 1) %>% 
  mutate(BA = round(H/AB,3)) %>% 
  select(BA)


### group_by/summarize 
Batting %>% summarise(BA = round(sum(H)/sum(AB),3))
foo = Batting %>% 
  group_by(playerID) %>% 
  summarise(BA = sum(H)/sum(AB), AB = sum(AB)) %>% 
  arrange(desc(BA)) %>% 
  filter(AB >= 3000)

### left_join 
bar = People %>% 
  mutate(name = paste(nameFirst, nameLast, sep = " ")) %>% 
  select(playerID, name)

foo %>% 
  left_join(bar, by = "playerID") %>% 
  select(playerID, name, everything())

## readr
dat = read_csv(file = "stat430sp25/notes/week2_wrangling_regression/season_eHR.csv")

## examples 

### career home runs (arranged from high to low; add final year; add name)
Batting %>% 
  select(playerID, yearID, HR) %>% 
  group_by(playerID) %>% 
  summarise(HR = sum(HR), finalYear = max(yearID)) %>% 
  left_join(bar)


## ggplot2 

### career home runs by final year 
foo = Batting %>% 
  select(playerID, yearID, HR, AB) %>% 
  group_by(playerID) %>% 
  summarise(HR = sum(HR), finalYear = max(yearID), AB = sum(AB)) %>% 
  filter(AB >= 1000) %>% 
  select(-AB)

ggplot(foo) +
  aes(x = finalYear, y = HR) + 
  geom_point() + 
  geom_smooth() + 
  theme_minimal() + 
  labs(title = "Home runs vs final year", 
       x = "final year", 
       y = "home runs")

ggplot(foo) +
  aes(x = finalYear, y = HR) + 
  geom_smooth() + 
  theme_minimal() + 
  labs(title = "Home runs vs final year", 
       x = "final year", 
       y = "home runs")

### career home runs vs era-adjusted home runs by final year
bar = dat %>% 
  group_by(playerID) %>% 
  summarise(HR = sum(HR), finalYear = max(year), AB = sum(AB)) %>% 
  filter(AB >= 1000) %>% 
  select(-AB)
 
ggplot(bar) +
  aes(x = finalYear, y = HR) + 
  geom_smooth() + 
  theme_minimal() + 
  labs(title = "Era-adjusted home runs vs final year", 
       x = "final year", 
       y = "home runs")

datHR = bind_rows(foo, bar, .id = "id") %>% 
  mutate(id = ifelse(id == 1, "observed", "era-adjusted"))

ggplot(datHR) +
  aes(x = finalYear, y = HR, col = id) + 
  geom_smooth() + 
  theme_minimal() + 
  labs(title = "Comparison of career observed and era-adjusted home runs counts", 
       x = "final year", 
       y = "home runs")

### single season HR by position 1982-1993 (minimum 100 AB)
Fielding_small = Fielding %>% 
  select(playerID, yearID, POS, InnOuts) %>% 
  group_by(playerID, yearID) %>% 
  filter(InnOuts == max(InnOuts)) %>% 
  filter(POS != "P", !is.na(POS)) %>% 
  rename("primaryPOS" = POS) %>% 
  select(playerID, yearID, primaryPOS)

Batting %>% 
  filter(yearID >= 1982, yearID <= 1993, AB >= 100) %>% 
  select(playerID, yearID, HR) %>% 
  left_join(Fielding_small) %>% 
  filter(!is.na(primaryPOS)) %>% 
  ggplot() + 
  aes(x = HR, y = primaryPOS, fill = primaryPOS) + 
  geom_density_ridges() + 
  theme_minimal() + 
  labs(title = "Distribution of seasonal home run counts", 
       subtitle = "by primary position", 
       x = "home runs", 
       y = "primary position")

#### Notes: 
## https://daviddalpiaz.org/posts/moneyball-in-r/



