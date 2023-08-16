nrow(hw1[hw1$VAL >= 24,])

df <- data.frame( c( 183, 85, 40), c( 175, 76, 35), c( 178, 79, 38 ))
names(df) <- c("Height", "Weight", "Age")

# All Rows and All Columns
df[,]
# First row and all columns
df[1,]
# First two rows and all columns
df[1:2,]
# First and third row and all columns
df[ c(1,3), ]
# First Row and 2nd and third column
df[1, 2:3]
# First, Second Row and Second and Third COlumn
df[1:2, 2:3]
# Just First Column with All rows
df[, 1]
# First and Third Column with All rows
df[,c(1,3)]

data <- df[1:23, 7:15]