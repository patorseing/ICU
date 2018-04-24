getwd()
setwd("/Users/napatcholthaipanich/Desktop/ICU")
getwd()
dir()

# Load the readxl package
library(readxl)

#print name of sheet
excel_sheets("ICU_Project160804 - RRTS Thai Data.xlsx")

#read two sheet from excel
OL <- read_excel("ICU_Project160804 - RRTS Thai Data.xlsx", sheet = "one_line_record")
ML <- read_excel("ICU_Project160804 - RRTS Thai Data.xlsx", sheet = "multiple_line_record")

#try to remove the variables that have too much missing data on one_line_record
#cut missing data
#if missing data is more than 90%
OLtry1<- OL
OLtry1[, which(colMeans(is.na(OLtry1))>0.9)] <- NULL
summary(OLtry1)
names(OLtry1)
#if missing data is more than 80%
OLtry2<- OL
OLtry2[, which(colMeans(is.na(OLtry2))>0.8)] <- NULL
summary(OLtry2)
names(OLtry2)
#if missing data is more than 70%
OLtry3<- OL
OLtry3[, which(colMeans(is.na(OLtry3))>0.7)] <- NULL
summary(OLtry3)
names(OLtry3)
#if missing data is more than 60%
OLtry4<- OL
OLtry4[, which(colMeans(is.na(OLtry4))>0.6)] <- NULL
summary(OLtry4)
names(OLtry4)
#if missing data is more than 50%
OLtry5<- OL
OLtry5[, which(colMeans(is.na(OLtry5))>0.5)] <- NULL
summary(OLtry5)
names(OLtry5)
#if missing data is more than 40%
OLtry6<- OL
OLtry6[, which(colMeans(is.na(OLtry6))>0.4)] <- NULL
summary(OLtry6)
names(OLtry6)
#if missing data is more than 30%
OLtry7<- OL
OLtry7[, which(colMeans(is.na(OLtry7))>0.3)] <- NULL
summary(OLtry7)
names(OLtry7)
#if missing data is more than 20%
OLtry8<- OL
OLtry8[, which(colMeans(is.na(OLtry8))>0.2)] <- NULL
summary(OLtry8)
names(OLtry8)
#if missing data is more than 10%
OLtry9<- OL
OLtry9[, which(colMeans(is.na(OLtry9))>0.1)] <- NULL
summary(OLtry9)
names(OLtry9)
#if missing data is more than 5%
OLtry91<- OL
OLtry91[, which(colMeans(is.na(OLtry91))>0.05)] <- NULL
summary(OLtry91)
names(OLtry91)
#if missing data is more than 1%
OLtry92<- OL
OLtry92[, which(colMeans(is.na(OLtry92))>0.01)] <- NULL
summary(OLtry92)
names(OLtry92)

#try to remove the variables that have too much missing data on one_line_record
#cut missing data
#if missing data is more than 90%-50% not work
#if missing data is more than 40%
MLtry6<- ML
MLtry6[, which(colMeans(is.na(MLtry6))>0.4)] <- NULL
summary(MLtry6)
names(MLtry6)
#if missing data is more than 30%
MLtry7<- ML
MLtry7[, which(colMeans(is.na(MLtry7))>0.3)] <- NULL
summary(MLtry7)
names(MLtry7)
#if missing data is more than 20%
MLtry8<- ML
MLtry8[, which(colMeans(is.na(MLtry8))>0.2)] <- NULL
summary(MLtry8)
names(MLtry8)
#if missing data is more than 10%
MLtry9<- ML
MLtry9[, which(colMeans(is.na(MLtry9))>0.1)] <- NULL
summary(MLtry9)
names(MLtry9)
#if missing data is more than 5%
MLtry91<- ML
MLtry91[, which(colMeans(is.na(MLtry91))>0.05)] <- NULL
summary(MLtry91)
names(MLtry91)
#if missing data is more than 1%
MLtry92<- ML
MLtry92[, which(colMeans(is.na(MLtry92))>0.01)] <- NULL
summary(MLtry92)
names(MLtry92)
