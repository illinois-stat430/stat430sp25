
library(tidyverse)
library(Lahman)

## get relevant path to statcast data set
sc = read_csv("~/Downloads/statcast.csv")
head(sc)
tail(sc)
dim(sc)
colnames(sc)


# get balls in play and isolate relevant variables
# (feel free to play around with relevant variables)
sc_bip = sc %>% filter(type == "X") %>% 
  dplyr::select(game_date, events, batter_name, stand, p_throws, pitcher_name, pitch_type, 
                launch_speed, launch_angle, hc_x, hc_y, release_speed, release_spin_rate, 
                #spin_dir,
                pfx_x, pfx_z, plate_x, plate_z, if_fielding_alignment, 
                estimated_ba_using_speedangle, estimated_woba_using_speedangle, 
                of_fielding_alignment, batter, pitcher)
dim(sc_bip)
head(sc_bip)
tail(sc_bip)

# store data set, correcting paths
write_csv(sc_bip, file = "~/Desktop/STAT430/sc_bip_small.csv")
