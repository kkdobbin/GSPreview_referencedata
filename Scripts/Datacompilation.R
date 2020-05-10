#Load libraries
library(dplyr)

#Load data
DACs <- read.csv("Data/DACs.csv")
Cities <- read.csv("Data/Cities.csv")
PWSs <- read.csv("Data/PWSs.csv")
CWSs <- read.csv("Data/CWSs.csv")
Pubwells <- read.csv("Data/PSWs.csv")
domwells <- read.csv("Data/Domesticwells.csv")

# Making summary table components
#Cities
Column1 <- Cities %>%
  group_by(GSA_Name) %>%
  summarize("City names" = paste(unique(Place), collapse = ", "))
#DACs
Column2 <- DACs %>%
  group_by(GSA_Name) %>%
  summarize("DAC names" = paste(unique(DAC_NAMELSAD), collapse = ", "))
#CWSs
Column3 <- CWSs %>%
  group_by(GSA_Name) %>%
  summarize("CWS names" = paste(unique(PWS_name), collapse = ", "))
#PWSs
Column4 <- PWSs %>%
  group_by(GSA_Name) %>%
  summarize("PWS names" = paste(unique(PWS_name), collapse = ", "))
#number cities
Column5 <- Cities %>% group_by(GSA_Name) %>% summarize("Number of cities" = n_distinct(Place))
#Number DACs
Column6 <- DACs %>% group_by(GSA_Name) %>% summarize("Number of DAC places" = n_distinct(DAC_NAMELSAD))
#Number CWSs
Column7 <- CWSs %>% group_by(GSA_Name) %>% summarize("Number of Community Water Systems (CWSs)" = n_distinct(PWS_name))
#Number PWSs
Column8 <- PWSs %>% group_by(GSA_Name) %>% summarize("Number of Public Water Systems (PWSs)" = n_distinct(PWS_name))
#Number of public supply wells
Column9 <- Pubwells %>% group_by(GSA_Name) %>% summarize("Number of Public Supply Wells" = n())
#Number of domestic supply wells already summarized
domwells <- domwells %>% rename('Number of Domestic Wells' = Domestic.Wells.Per.GSA) 

#Join
Data1 <- full_join(Column1, Column2, by = "GSA_Name")
Data2 <- full_join(Data1, Column3, by = "GSA_Name")
Data3 <- full_join(Data2, Column4, by = "GSA_Name")
Data4 <- full_join(Data3, Column5, by = "GSA_Name")
Data5 <- full_join(Data4, Column6, by = "GSA_Name")
Data6 <- full_join(Data5, Column7, by = "GSA_Name")
Data7 <- full_join(Data6, Column8, by = "GSA_Name")
Data8 <- full_join(Data7, Column9, by = "GSA_Name")
Finaldata <- Data8
Finaldata <- Finaldata[c(1,6,2,7,3,8,4,9,5,10)]

#export csv
write.csv(Finaldata, file = "FinalData/Joineddata.csv", row.names = F)

#Write out a data set for domestic wells 
DomesticWellData <- domwells[-3]
write.csv(DomesticWellData, file = "FinalData/domesticwelldata.csv", row.names = F)
