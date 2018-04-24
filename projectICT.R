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
