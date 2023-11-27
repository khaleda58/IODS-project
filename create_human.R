

# libraries
library(readr)
library(dplyr)

# data wrangling part 1
# ---------------------

# read human develop and gender inequality data
hd <- read.csv("data/human_development.csv", stringsAsFactors = F)
gii <- read.csv("data/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Data exploration
str(hd)
dim(hd)
summary(gii)

str(gii)
dim(gii)
summary(gii)


# rename variables
names(hd) <- c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", 
"GNI", "GNI.Minus.Rank")
names(gii) <- c("GII.Rank", "Country", "GII", "Mat.Mor", 
               "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", 
               "Labo.F", "Labo.M")


# Adding new variables
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Labo.FM = Labo.F / Labo.M)

# join data and write to file
human <- inner_join(hd, gii, by = "Country")
write_csv(human, 'data/human.csv')

