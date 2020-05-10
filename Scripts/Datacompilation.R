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
Test1 <- Cities %>%
  group_by(GSA_Name) %>%
  summarize("City names" = paste(unique(Place), collapse = ", "))
#DACs
Test2 <- DACs %>%
  group_by(GSA_Name) %>%
  summarize("DAC names" = paste(unique(DAC_NAMELSAD), collapse = ", "))
#CWSs
Test3 <- CWSs %>%
  group_by(GSA_Name) %>%
  summarize("CWS names" = paste(unique(PWS_name), collapse = ", "))
#PWSs
Test4 <- PWSs %>%
  group_by(GSA_Name) %>%
  summarize("PWS names" = paste(unique(PWS_name), collapse = ", "))
#number cities
Test5 <- Cities %>% group_by(GSA_Name) %>% summarize("Number of cities" = n_distinct(Place))
#Number DACs
Test6 <- DACs %>% group_by(GSA_Name) %>% summarize("Number of DAC places" = n_distinct(DAC_NAMELSAD))
#Number CWSs
Test7 <- CWSs %>% group_by(GSA_Name) %>% summarize("Number of Community Water Systems (CWSs)" = n_distinct(PWS_name))
#Number PWSs
Test8 <- PWSs %>% group_by(GSA_Name) %>% summarize("Number of Public Water Systems (PWSs)" = n_distinct(PWS_name))
#Number of public supply wells
Test9 <- Pubwells %>% group_by(GSA_Name) %>% summarize("Number of Public Supply Wells" = n())
#Number of domestic supply wells already summarized
domwells <- domwells %>% rename('Number of Domestic Wells' = Domestic.Wells.Per.GSA) 

#Join
Data1 <- full_join(Test1, Test2, by = "GSA_Name")
Data2 <- full_join(Data1, Test3, by = "GSA_Name")
Data3 <- full_join(Data2, Test4, by = "GSA_Name")
Data4 <- full_join(Data3, Test5, by = "GSA_Name")
Data5 <- full_join(Data4, Test6, by = "GSA_Name")
Data6 <- full_join(Data5, Test7, by = "GSA_Name")
Data7 <- full_join(Data6, Test8, by = "GSA_Name")
Data8 <- full_join(Data7, Test9, by = "GSA_Name")
Finaldata <- Data8
Finaldata <- Finaldata[c(1,6,2,7,3,8,4,9,5,10)]

#export csv
write.csv(Finaldata, file = "Outputs/Finaldata.csv", row.names = F)
