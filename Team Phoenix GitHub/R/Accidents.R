install.packages(c("ggplot2", "ggpubr", "tidyverse", "broom", "AICcmodavg"))
install.packages("writexl")

library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)
library(writexl)
library(dplyr)
library(gmodels)

##Recoding MONTH to MonthName
Accidents <- accident %>% mutate(Season = recode(MONTH, 
                                                     '1'= "Winter",
                                                     '2'= "Winter",
                                                     '3'= "Spring", 
                                                     '4'= "Spring", 
                                                     '5'= "Spring",
                                                     '6'= "Summer",
                                                     '7'= "Summer",
                                                     '8'= "Summer", 
                                                     '9' = "Fall",
                                                     '10' = "Fall", 
                                                     '11' = "Fall",
                                                     '12' = "Winter"))
                                                     
                                 
                              
View(Accidents)

#Total Number of Accidents By Season
SeasonAccidents <- table(Accidents$Season)
View(SeasonAccidents)


#Total Number of Fatalities By Season
SeasonFatalities <- Accidents %>% group_by(Season) %>% summarize(TotalFatalAccidents = sum(FATALS))
View(SeasonFatalities)

#Statistical Analysis 

#ANOVA? 
MFAnova <- aov(TotalFatalAccidents ~ MonthName, data = MonthFatalAccidentsCounts)
summary(MFAnova)
#NOPE!

#Frequency and Percents?
#Ask team

#Saving MonthFatalAccidentsCounts Data Frame to Excel
write_xlsx(MonthFatalAccidentsCounts,"C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\MonthlyFatalAccidentsCounts.xlsx")

#Saving MonthAccidentsCounts Data Frame to Excel
write_xlsx(MonthAccidentsCounts,"C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\MonthAccidentsCounts.xlsx")

#Number of Fatal Accidents
count(Accidents, 'FATALS')


##Subsetting Spring and Summer months fatalities
SpringSummerFatalities <- subset(Accidents, !(Season %in% c("Winter", "Fall")))
View(SpringSummerFatalities)

##Only Spring and Summer fatalities
SSF <- subset(SpringSummerFatalities, select = c(FATALS, Season))
View(SSF)

##Saving Spring and Summer fatalities dataframe to Excel
write_xlsx(SSF, "C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\SSF.xlsx")

##Saving Spring fatalities to Excel
write_xlsx(SpringMonthFatalAccidentsCounts, "C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\SpringFatalities.xlsx")

##Saving Summer Fatalities to Excel
write_xlsx(SummerMonthFatalAccidentsCounts, "C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\SummerFatalities.xlsx")


#Spring Total Accidents
SpringMonthAccidentsCounts <- MonthAccidentsCounts[-c(3, 4, 5, 10, 11, 12, 2, 6, 7)]
View(SpringMonthAccidentsCounts)
#Summer Total Accidents
SummerMonthAccidentsCounts <- MonthAccidentsCounts[-c(3, 4, 5, 10, 11, 12, 1, 8, 9)]
View(SummerMonthAccidentsCounts)

#Spring Total Fatal Accidents
SpringMonthFatalAccidentsCounts <- MonthFatalAccidentsCounts[-c(3, 4, 5, 10, 11, 12, 2, 6, 7), ]
View(SpringMonthFatalAccidentsCounts)

#Summer Total Fatal Accidents
SummerMonthFatalAccidentsCounts <- MonthFatalAccidentsCounts[-c(3, 4, 5, 10, 11, 12, 1, 8, 9), ]
View(SummerMonthFatalAccidentsCounts)

#Plotting Spring Total Accidents by refactoring months
SpringTA <- SpringMonthAccidentsCounts %>% mutate(Var1 = factor(Var1, levels = c("March", "April", "May")))

##Is there a significant difference between fatal accidents in the spring and summer?
##t-test
t.test(FATALS ~ Season, var.equal = TRUE, data = SSF)

