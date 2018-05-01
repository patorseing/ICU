getwd()
setwd("/Users/napatcholthaipanich/Desktop/ICU")
getwd()
dir()

#function to find missing percent
miss <- function(x){sum(is.na(x))/length(x)*100}

# Load the readxl package
library(readxl)

#print name of sheet
excel_sheets("ICU_Project160804 - RRTS Thai Data.xlsx")

#read two sheet from excel
OL <- read_excel("ICU_Project160804 - RRTS Thai Data.xlsx", sheet = "one_line_record")
ML <- read_excel("ICU_Project160804 - RRTS Thai Data.xlsx", sheet = "multiple_line_record")
#list the original feature
names(OL)

#list the original feature
names(ML)

library(data.table)

testOL <- data.table(col = names(OL),miss = apply(OL,2,miss)) # Show in columns
testML <- data.table(ML$site, ML$patient_order,miss =apply(ML,1,miss))
testmore <- test[test$miss>10]
table(test$miss<10)

#if missing data is more than 10%
OLtry<-OL
OLtry[, which(colMeans(is.na(OLtry))>0.1)] <- NULL
summary(OLtry)
names(OLtry)

#read the feature that doctor recommend
modelfile <- read.csv("extracted_data_1.csv")
summary(modelfile)
names(modelfile)
#from ml
mod <- data.frame(id = 1:nrow(OL), ht = OL$ht, dm = OL$dm, cad = OL$cad, cerebrovascular_disease = OL$cerebrovascular_disease, malignancy = OL$malignancy, ckd = OL$ckd, esrd = OL$esrd, baseline_serum_creainine_by_mdrd = OL$baseline_serum_creainine_by_mdrd, True_baseline_serum_cr = OL$True_baseline_serum_cr, first_available_cr = OL$first_available_cr, apache_ii = OL$apache_ii, cr_diagnosis = OL$cr_diagnosis, cr_staging = OL$cr_staging, urine_output24hr_1 = OL$urine_output24hr_1, urine_output24hr_2 = OL$urine_output24hr_2, urine_output24hr_3 = OL$urine_output24hr_3, vasopressor_1 = OL$vasopressor_1, vasopressor_2 = OL$vasopressor_2, vasopressor_3 = OL$vasopressor_3, sofa_1 = OL$sofa_1, sofa_2 = OL$sofa_2, sofa_3 = OL$sofa_3, icu_discharge_status = OL$icu_discharge_status, if_rrt_1 = OL$if_rrt_1, if_rrt_2 = OL$if_rrt_2, if_rrt_3 = OL$if_rrt_3)
mod$baseline <- NA
names(mod)
summary(mod)

mod$first_available_cr <- as.numeric(as.character(mod$first_available_cr))
mod$urine_output24hr_1 <- as.numeric(as.character(mod$urine_output24hr_1))
mod$urine_output24hr_2 <- as.numeric(as.character(mod$urine_output24hr_2))
mod$urine_output24hr_3 <- as.numeric(as.character(mod$urine_output24hr_3))

mod$vasopressor_1<-as.factor(ifelse(mod$vasopressor_1==1, "No","Yes"))
mod$vasopressor_2<-as.factor(ifelse(mod$vasopressor_2==1, "No","Yes"))
mod$vasopressor_3<-as.factor(ifelse(mod$vasopressor_3==1, "No","Yes"))

mod$if_rrt_1<-as.factor(ifelse(mod$if_rrt_1==1, "No","Yes"))
mod$if_rrt_2<-as.factor(ifelse(mod$if_rrt_2==1, "No","Yes"))
mod$if_rrt_3<-as.factor(ifelse(mod$if_rrt_3==1, "No","Yes"))

mod$icu_discharge_status<-as.factor(ifelse(mod$icu_discharge_status==0, "Alive","Death"))

#clean

for (i in 1:ncol(mod)) {
    if(is.factor(mod[,i])){
        mod[is.na(mod[,i]),i] <- "No"
    }
}

for (i in 1:nrow(mod)) {
    if(is.na(mod$True_baseline_serum_cr[i])){
        if(is.na(mod$first_available_cr[i]) && !is.na(mod$baseline_serum_creainine_by_mdrd[i])){
            mod$baseline[i] <- mod$baseline_serum_creainine_by_mdrd[i]
        } else if(is.na(mod$baseline_serum_creainine_by_mdrd[i]) && !is.na(mod$first_available_cr[i])){
            mod$baseline[i] <- mod$first_available_cr[i]
        } else if(!is.na(mod$baseline_serum_creainine_by_mdrd[i]) && !is.na(mod$first_available_cr[i])){
            if(mod$baseline_serum_creainine_by_mdrd[i] > mod$first_available_cr[i]){
                mod$baseline[i] <- mod$first_available_cr[i]
            } else{
                mod$baseline[i] <- mod$baseline_serum_creainine_by_mdrd[i]
            }
        } 
    }
    else{
        mod$baseline[i] <- mod$True_baseline_serum_cr[i]
    }
}
mod["True_baseline_serum_cr"] <- NULL
mod["first_available_cr"] <- NULL
mod["baseline_serum_creainine_by_mdrd"] <- NULL
mod<-mod[!(is.na(mod$baseline)),]
mod[is.na(mod)] <- 0
mod$icu_discharge_status[is.na(mod$icu_discharge_status)] <- "Alive"
summary(mod)
write.csv(mod, "extract_OL.csv")

head(mod)
tail(mod)

library(dplyr)
glimpse(mod)

for (i in 1:ncol(mod)) {
    if(is.factor(mod[,i])){
        if(levels(mod[,i])[1]=="No"){
            mod[,i] <- as.numeric(ifelse(mod[,i]=="No", 1,0))  
        } else if(levels(mod[,i])[1]=="Alive"){
            mod[,i] <- as.numeric(ifelse(mod[,i]=="Alive", 0,1))  
        }
    }
}

glimpse(mod)
cor(mod)

