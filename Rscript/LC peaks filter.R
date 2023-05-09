setwd("~/Desktop/Jiali/TAMU/xiaohan/S12/data/")

blank <- read.table("MSlabData/050623LC-B2.peaks.txt", header = F, sep = " ")
names(blank)[3:6] <- c('id','rt','mz','it')
sample <- read.table("MSlabData/050623LC-01.peaks.txt", header = F, sep = " ")
names(sample)[3:6] <- c('id','rt','mz','it')
sample$mz <- gsub("mz=","",sample$mz)
sample$mz <- round(as.numeric(sample$mz),4)
S01 <- data.frame(table(sample$mz))
blank$mz <- gsub("mz=","",blank$mz)
blank$mz <- round(as.numeric(blank$mz),4)
B02 <- data.frame(table(blank$mz))

intersect(S01$Var1,B02$Var1)
length(S01[!(S01$Var1 %in% intersect(S01$Var1,B02$Var1)),]$Var1)

sample_filtered <- sample[!(sample$mz %in% blank$mz),]
table(sample_filtered$mz)
