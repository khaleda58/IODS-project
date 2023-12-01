

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

#Explanation of short name

#"Country" = Country name

# Health and knowledge

#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate

# Empowerment

#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force

#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M

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

##Data wrangling part 2:
human <- read_csv('data/human.csv')
str(human)
dim(human)
colnames(human)
summary(human)

#Description of data set:
#This data set is consist of 195 observations and 19 variables. The details of 
#short version of column name has given above. 
#The Human Development Index (HDI) is a summary measure of average achievement 
#in key dimensions of human development: a long and healthy life, 
#being knowledgeable and having a decent standard of living. 
#The HDI is the geometric mean of normalized indices for each of 
#the three dimensions.

#The health dimension is assessed by life expectancy at birth, 
#the education dimension is measured by mean of years of schooling for adults 
#aged 25 years and more and expected years of schooling for children of school 
#entering age. The standard of living dimension is measured by gross national 
#income per capita. The HDI uses the logarithm of income, 
#to reflect the diminishing importance of income with increasing GNI. 
#The scores for the three HDI dimension indices are then aggregated into a 
#composite index using geometric mean. Refer to Technical notes for more details.

#Removal of unneeded variables:

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", 
          "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

#checking missing values
colSums(is.na(human))

#Removing missing value
human <- human[complete.cases(human),]

#Removing the observations related to region
tail(human,10)
last <- nrow(human) - 7
human <- human[1:last,]

dim(human)

write.csv(human, "data/human.csv")
