library(data.table)
library(dplyr)
library(tidyr)

setwd("C:\\Users\\User15\\Documents")
df1 <- read.csv(".\\paramsExp.csv", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings=c(""," ","NA"))
df2 <- read.csv(".\\paramsWeb1.csv", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings=c(""," ","NA"))

expSub <- data.frame(df1$CHART, df1$YEAR, df1$T0, df1$T1, df1$CLOUD_COVER, df1$DTID, df1$SENSOR)  
webSub <- data.frame(df2$n, df2$Año, df2$ID.Árbol..de.decisión.MapBiomas.Brasil)  

webSli <- webSub %>% slice(1:476)


colnames(expSub)[which(names(expSub) == "df1.CHART")] <- "CHART"
colnames(expSub)[which(names(expSub) == "df1.YEAR")] <- "YEAR"
colnames(expSub)[which(names(expSub) == "df1.T0")] <- "T0"
colnames(expSub)[which(names(expSub) == "df1.T1")] <- "T1"
colnames(expSub)[which(names(expSub) == "df1.CLOUD_COVER")] <- "CLOUD_COVER"
colnames(expSub)[which(names(expSub) == "df1.DTID")] <- "DT_ID"
colnames(expSub)[which(names(expSub) == "df1.SENSOR")] <- "SENSOR"

colnames(webSli)[which(names(webSli) == "df2.n")] <- "CHART"
colnames(webSli)[which(names(webSli) == "df2.Año")] <- "YEAR"
colnames(webSli)[which(names(webSli) == "df2.X..de.nubes")] <- "CLOUD_COVER"
colnames(webSli)[which(names(webSli) == "df2.Landsat.5")] <- "SENSOR"
colnames(webSli)[which(names(webSli) == "df2.ID.Árbol..de.decisión.MapBiomas.Brasil")] <- "DT_ID"
colnames(webSli)[which(names(webSli) == "df2.Label.ID.Árbol..de.decisión.MapBiomas.Brasil")] <- "DT_LABEL"


expFil <- subset(expSub, CHART %in% webSli$CHART)

webSli$DT_ID[webSli$DT_ID== 117] <- 118
webSli$DT_ID[webSli$DT_ID== 100] <- 118
webSli$DT_ID[webSli$DT_ID== 75] <- 118 
webSli$DT_ID[webSli$DT_ID== 70] <- 118 
webSli$DT_ID[webSli$DT_ID== 60] <- 118 

webSli[is.na(webSli)]=118

total <- merge(expFil, webSli, by = c('CHART', 'YEAR'), all = T)

total$DT_ID.x <- NULL
colnames(total)[which(names(total) == "DT_ID.y")] <- "DT_ID"

total$SENSOR[total$CHART=="NA-20-V-A" & is.na(total$SENSOR)] <- "L8"

write.csv(total, file = "c:\\Users\\User15\\Documents\\cartasFronterizas.csv", row.names = TRUE)