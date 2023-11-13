

#Khaleda Begum
#November 11, 2023
#This is the R script where I will produce all the necessary R code.

#Loading packages
library(tidyverse)

#Reading the data from the web

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
                    sep="\t", header=TRUE)

dim(lrn14)
str(lrn14)

# Creating analysis dataset

lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

#In this data set there are 183 observations and 60 variables. 
#All the variable are here in integer except the gender, 
#which is in character format.

# New dataset:
learning2014 <- subset(lrn14, select = c("gender","Age","attitude", "deep", "stra", "surf", "Points"))

# Renaming few columns in learning2014 dataset
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

## Excluding observations
learning2014 <- filter(learning2014, points > 0)

## Saving analysis dataset in 'Data' folder

write_csv(learning2014, 'Data/learning2014.csv')
setwd("D:/PHD Study/IODS-project")
check_learning2014 <- read_csv("Data/learning2014.csv")

dim(check_learning2014)
str(check_learning2014)
