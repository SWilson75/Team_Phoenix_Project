install.packages(c("ggplot2", "ggpubr", "tidyverse", "broom", "AICcmodavg"))
install.packages("writexl")

library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)
library(writexl)

#Recoding MONTH to MonthName
Accidents <- accident %>% mutate(MonthName = recode(MONTH, 
                                                     '1'= "January",
                                                     '2'= "February",
                                                     '3'= "March", 
                                                     '4'= "April", 
                                                     '5'= "May",
                                                     '6'= "June",
                                                     '7'= "July",
                                                     '8'= "August", 
                                                     '9' = "September",
                                                     '10' = "October", 
                                                     '11' = "November",
                                                     '12' = "December"))
                                                     
                                 
                              
View(Accidents)

#Total Number of Accidents By Month
MonthAccidentsCounts <- table(Accidents$MonthName)
View(MonthAccidentsCounts)

#Total Number of Fatal Accidents By Month
MonthFatalAccidentsCounts <- Accidents %>% group_by(MonthName) %>% summarize(TotalFatalAccidents = sum(FATALS))
View(MonthFatalAccidentsCounts)

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
write_xlsx(MonthFatalAccidentsCounts,"C:\\Users\\snbya\\OneDrive\\Documents\\ENTITY\\110 Final Project\\MonthAccidentsCounts.xlsx")