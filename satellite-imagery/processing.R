setwd("~/Documents")
data <- read.csv("./Excel_Maxent_SDM_Main02_MAYReport.csv")
semiClean <- data[-1, -(c(1, 4:10)), drop=FALSE]
Clean <- unique(semiClean)
write.csv(semiClean, file = "./semiClean.csv", row.names = TRUE)
write.csv(Clean, file = "./Clean.csv", row.names = TRUE)


