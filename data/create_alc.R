
#Name: Khaleda Begum
#Date: November 17, 2023
#This script is for data wrangling for the assignment 3. Here data have been
#extarcted from https://www.archive.ics.uci.edu/dataset/320/student+performance.

#Loading required packages:
library(tidyverse)
library(dplyr)
library(ggplot2)

#Reading data
d1=read.table("data/student-mat.csv",sep=";",header=TRUE)
d2=read.table("data/student-por.csv",sep=";",header=TRUE)

dim(d1)
str(d1)

dim(d2)
str(d2)

#Joining two data frames in folowing 3 ways:

d3 <- merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu",
                    "Fedu","Mjob","Fjob","reason","guardian",
                    "traveltime","studytime","schoolsup","famsup", "activities", 
                    "nursery","higher","internet",
                    "romantic","famrel","freetime","goout","Dalc","Walc",
                    "health"))

d3 <- inner_join(d1, d2, by = c("school","sex","age","address","famsize","Pstatus","Medu",
                                "Fedu","Mjob","Fjob","reason","guardian",
                                "traveltime","studytime","schoolsup","famsup", "activities", 
                                "nursery","higher","internet",
                                "romantic","famrel","freetime","goout","Dalc","Walc",
                                "health"))

free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(d2), free_cols)
d3 <- inner_join(d1, d2, by = join_cols, suffix = c(".d1", ".d2"))

glimpse(d3)

#Get rid of duplicate records:

colnames(d3)
alc <- select(d3, all_of(join_cols))
glimpse(alc)

for(col_name in free_cols) {
  two_cols <- select(d3, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

glimpse(alc)

##Creating new column according to instruct 6

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2 )
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

#Reading dataframe in data folder

write_csv(alc, 'data/alc.csv')
