library(haven)
library(tidyverse)

raw_data <- read_csv("/Users/mac/Desktop/kidney_disease.csv")

#select variables that interested 
selected_data <- raw_data %>% select(age, bp, sg, ane, appet, classification) 
selected_data$age <- as.numeric(selected_data$age)
head(selected_data)

#filter all the N/A in the classification 
selected_data <- selected_data %>% filter(!is.na(classification))

#clean selected data 
selected_data <-
  selected_data %>%
  mutate(ckd = 
           ifelse(classification == "ckd", 1, 0)) 

#revome classification variable and all the N/A in the selected data
selected_data <- subset(selected_data, select=-c(classification))
selected_data <- na.omit(selected_data)

#filter varibales ane and appet
selected_data <-
  selected_data %>% filter(ane == "yes" | ane == "no")

selected_data <-
  selected_data %>% filter(appet == "good" | appet == "poor")


selected_data$ane <- as.factor(selected_data$ane)
selected_data$appet <- as.factor(selected_data$appet)
selected_data$ckd <- as.factor(selected_data$ckd)

#look at my selected data
str(selected_data)

# Save the cleaned data csv file in working directory 
write_csv(selected_data, "ckd_data.csv")

