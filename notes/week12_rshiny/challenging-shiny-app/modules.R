
########################################
### Load in and wrangle population data
########################################
population_data <- read.csv("population.csv", header = TRUE)[, -1] %>% 
  mutate(age20 = age20 / 1e3, age25 = age25 / 1e3) %>% 
  filter(year > 1950)
population_data$region <- as.factor(population_data$region)
population_data$region <- recode_factor(population_data$region, WORLD = "world")

### Canadian population before 1960
#https://www65.statcan.gc.ca/acyb02/1907/acyb02_1907001701a-eng.htm
Can1881 <- 0.21 + 0.17
#https://www65.statcan.gc.ca/acyb02/1907/acyb02_1907001701a-eng.htm
Can1891 <- 0.24 + 0.19  
#https://www65.statcan.gc.ca/acyb02/1907/acyb02_1907001701a-eng.htm
Can1901 <- 0.26 + 0.22
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
CanM1881 <- 2.19  
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
CanM1891 <- 2.16  
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
CanM1901 <- 2.75
propCan2030 <- (Can1881 + Can1891 + Can1901) / 
  (CanM1881 + CanM1891 + CanM1901)
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
Can1911 <- 3.82 * propCan2030  
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
Can1921 <- 4.53 * propCan2030 
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
Can1931 <- 5.37 * propCan2030 
#https://www65.statcan.gc.ca/acyb02/1947/acyb02_19470113009-eng.htm
Can1941 <- 5.90 * propCan2030 
#https://www65.statcan.gc.ca/acyb02/1967/acyb02_19670194010-eng.htm
Can1951 <- 7.09 * propCan2030 

### US population before 1960
#https://www2.census.gov/library/publications/decennial/1880/vol-01-population/1880_v1-15.pdf
US1880 <- 2.22 + 1.84  
#https://www2.census.gov/library/publications/decennial/1900/volume-2/volume-2-p5.pdf
US1900 <- 2.73 + 2.37  
US1890 <- mean(c(US1880,US1900))
#https://www2.census.gov/library/publications/decennial/1910/volume-1/volume-1-p6.pdf
US1910 <- 4.07 + 3.79  
#https://www2.census.gov/library/publications/decennial/1920/volume-2/41084484v2ch03.pdf
US1920 <- 4.02 + 4.09  
#https://www2.census.gov/library/publications/decennial/1930/population-volume-2/16440598v2ch11.pdf
US1930 <- 4.69 + 4.25  
#https://www2.census.gov/library/publications/decennial/1940/population-volume-4/33973538v4p1ch1.pdf
US1940 <- 1.08 + 1.06 + 1.01 + 1.00 + 1.01 + 
  1.01 + 0.99 + 0.98 + 0.97 + 0.95 
#https://www2.census.gov/library/publications/decennial/1950/population-volume-2/21983999v2p1ch2.pdf
US1950 <- 5.00 + 5.30 

Can <- c(Can1881, Can1891, Can1901, Can1911, Can1921, Can1931, Can1941, Can1951)
US <- c(US1880, US1890, US1900, US1910, US1920, US1930, US1940, US1950)




