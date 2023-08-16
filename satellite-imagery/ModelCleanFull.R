#Load libraries

library(data.table)
library(dplyr)
library(tidyr)

#Read files

setwd("C:\\Users\\User15\\Documents\\MapBiomas")
df1 <- read.csv(".\\paramsExp.csv", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings=c(""," ","NA"))
df2 <- read.csv(".\\paramsWebFull.csv", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings=c(""," ","NA"))

#Filter only wanted variables

expSub <- data.frame(df1$CHART, df1$YEAR, df1$T0, df1$T1, df1$CLOUD_COVER, df1$SENSOR)  
webSub <- data.frame(df2$n, df2$Año, df2$ID.Árbol..de.decisión.MapBiomas.Brasil)
                      
webSli <- webSub %>% slice(1:765)

#Make names of both data frames equals

setnames(expSub, old = c('df1.CHART', 'df1.YEAR', 'df1.T0', "df1.T1", "df1.CLOUD_COVER", "df1.SENSOR"), 
         new = c('CHART', 'YEAR', 'T0', 'T1', 'CLOUD_COVER', 'SENSOR'))

setnames(webSli, old = c('df2.n', 'df2.Año', 'df2.ID.Árbol..de.decisión.MapBiomas.Brasil'), 
         new = c('CHART', 'YEAR', 'DT_ID'))

#Replace erroneous values of DT_ID

webSli$DT_ID <- replace(webSli$DT_ID, which(webSli$DT_ID==117 | webSli$DT_ID==100 | webSli$DT_ID==75 | webSli$DT_ID==70 
                                            | webSli$DT_ID==60 | is.na(webSli$DT_ID)), 118)

#Merge correct values of DT_ID

total <- merge(expSub, webSli, by = c('CHART', 'YEAR'), all = T)

#Finish the cleaning 

total$SENSOR[total$CHART=="NA-20-V-A" & is.na(total$SENSOR)] <- "L8"
total$SENSOR[total$CHART=="NB-19-X-B" & is.na(total$SENSOR)] <- "LX"
total$CLOUD_COVER[total$CHART=="NA-20-V-A" & is.na(total$CLOUD_COVER)] <- "65"
total$CLOUD_COVER[total$CHART=="NB-19-X-B" & is.na(total$CLOUD_COVER)] <- "75"
total$T0[total$CHART=="NA-20-V-A" & is.na(total$T0)] <- "2016-07-01"
total$T1[total$CHART=="NA-20-V-A" & is.na(total$T1)] <- "2016-10-31"
total$T0[total$CHART=="NB-19-X-B" & is.na(total$T0)] <- "2002-01-01"
total$T1[total$CHART=="NB-19-X-B" & is.na(total$T1)] <- "2002-04-30"

total$DT_ID <- replace(total$DT_ID, which(total$CHART!="NA-19-X-D" & total$CHART!="NB-19-Z-C" & total$CHART!="NB-20-V-B" 
                                        & total$CHART!="NB-20-X-A" & total$CHART!="NC-20-X-C" & total$CHART!="NC-20-X-D"  
                                        & total$CHART!="NC-20-Y-D" & total$CHART!="NC-20-Z-A" & total$CHART!="NC-20-Z-B" 
                                        & total$CHART!="NC-20-Z-C" & total$CHART!="NC-21-Y-C"), 118)


total$DT_ID <- replace(total$DT_ID, which(total$CHART=="NB-20-V-B" | total$CHART=="NB-20-X-A" | total$CHART=="NC-20-X-C" 
                                        | total$CHART=="NC-20-X-D" | total$CHART=="NC-20-Y-D" | total$CHART=="NC-20-Z-A"  
                                        | total$CHART=="NC-20-Z-B" | total$CHART=="NC-20-Z-C" | total$CHART=="NC-21-Y-C"), 126)


total$DT_ID <- replace(total$DT_ID, which(total$CHART=="NA-19-X-D" | total$CHART=="NB-19-Z-C"), "118 / 126")

#Export the data frame

write.csv(total, file = "c:\\Users\\User15\\Documents\\MapBiomas\\cartasFronterizas.csv", row.names = TRUE)
