# final project question 2 II final code
# does the type of distraction contribute to the number of fatalities in a year?
# linear regression

library("car")
library("caret")
library("gvlma")
library("predictmeans")
library("e1071")
library("lmtest")
library("abind")
library("IDPmisc")

# data wrangling
# data set has 38k+ rows, cut it down to 5k then cut it down to the columns needed

accident1 <- accident[1:300, 1:52]
keepsMore <- c("FATALS", "YEAR")
accident2 <- accident1[keepsMore]


distract1 <- distract[1:300, 1:4]
keeps <- c("STATE", "MDRDSTRD")
distract2 <- distract1[keeps]
str(distract2$STATE)
str(distract2$MDRDSTRD)


together <- abind(accident2, distract2)
together1 <- as.data.frame(together)
together2 <- NaRV.omit(together1)
str(together1$FATAL)



# test assumptions
# testing for linearity

scatter.smooth(x=together2$MDRDSTRD, y=together2$FATALS, main="Fatalities by method of distraction")
# there is a straight line with some outliers showing will correct for those if possible assumption passed

# test for homoscedasticity by creating the linear model bp test

togetherMod <- lm(FATALS~MDRDSTRD, data=together2)
par(mfrow=c(2,2))
plot(togetherMod)

# the two left plots show a line straight across assumption is met running breush pagan to be sure

lmtest::bptest(togetherMod)
# p value is greater than .05 assumption is passed

# homogeneity of variance
# per plots above assumption is passed

# GVLMA assumptions


gvlma(togetherMod)
# per results homoscedasticity assumption was not passed but per plots it was will continue with outlier tests

# testing for outliers must test for all three at once distance leverage influential
# first test for outliers in x space with a cook's distance test(predictmeans library




# per plot rows 30 83 95 are the outliers will try to correct before removing

# leverage outliers with hat()

lev = hat(model.matrix(togetherMod))
plot(lev)

# vertical lines straight across so far so good
# check for outlier in y space with car

car::outlierTest(togetherMod)
# row 30 83 95  is still showing as an outlier will try to correct for it

# test for outliers in x and y space


# dfb.1 & dffit have no values > 1 no influential outliers after changing df size 

# no influential outliers showing
# making a new df with n=300 to re run tests for better fitting per G*Power n=268

# the kind of distraction does have an impact on the amount of fatalties



