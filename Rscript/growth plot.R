setwd("~/Desktop/Jiali/TAMU/xiaohan/S12/data/")

library(ggplot2)
library(plyr)
library(reshape2)
library(Rmisc)
if(!require(lsmeans)){install.packages("lsmeans")}
# install.packages("multcompView")
# install.packages("multcomp")
library(multcompView)
library(lsmeans)
library(multcomp)

data3 <- read.csv("data-3-04062023.csv", header = T)
data3_melt <- melt(data3)

data3_melt$variable <- as.factor(c(rep(0,6), rep(10,6), rep(100,6)))
names(data3_melt) <- c("Treatment","Conc","Value")
datasum <- summarySE(data3_melt, measurevar = "Value", groupvars = c("Treatment","Conc"))
PFOA <- data3_melt[data3_melt$Treatment == "PFOA",]
PFOS <- data3_melt[data3_melt$Treatment == "PFOS",]

## Anova & Tukey test
model = lm(PFOS$Value ~ PFOS$Conc)
one.way <- aov(model)
summary(one.way)
TUKEY <- TukeyHSD(x=one.way, 'PFOS$Conc', conf.level=0.95)

generate_label_df <- function(TUKEY, variable){
  # Extract labels and factor levels from Tukey post-hoc 
  Tukey.levels <- TUKEY[[variable]][,4]
  Tukey.labels <- data.frame(multcompLetters(Tukey.levels)['Letters'])
  #I need to put the labels in the same order as in the boxplot :
  Tukey.labels$treatment=rownames(Tukey.labels)
  Tukey.labels=Tukey.labels[order(Tukey.labels$treatment) , ]
  return(Tukey.labels)
}

LABELS <- generate_label_df(TUKEY , "PFOS$Conc")

p<- ggplot(datasum[4:6,], aes(x=Conc, y=Value)) + 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=Value-sd, ymax=Value+sd), width=.5,
                position=position_dodge(.9)) +
  geom_text(aes(label = LABELS$Letters, y = Value + 0.1),
            position = position_dodge(0.9),
            vjust = 0,
            color   = "black")

p+labs(title="PFOS", x="Concentration (mg/L)", y = "OD630") + theme_classic(base_size = 14)
ggsave("PFOS tolerance.pdf", height = 3, width = 2.5)


model = lm(PFOA$Value ~ PFOA$Conc)
one.way <- aov(model)
summary(one.way)
TUKEY <- TukeyHSD(x=one.way, 'PFOA$Conc', conf.level=0.95)

generate_label_df <- function(TUKEY, variable){
  # Extract labels and factor levels from Tukey post-hoc 
  Tukey.levels <- TUKEY[[variable]][,4]
  Tukey.labels <- data.frame(multcompLetters(Tukey.levels)['Letters'])
  #I need to put the labels in the same order as in the boxplot :
  Tukey.labels$treatment=rownames(Tukey.labels)
  Tukey.labels=Tukey.labels[order(Tukey.labels$treatment) , ]
  return(Tukey.labels)
}

LABELS <- generate_label_df(TUKEY , "PFOA$Conc")

p<- ggplot(datasum[1:3,], aes(x=Conc, y=Value)) + 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=Value-sd, ymax=Value+sd), width=.5,
                position=position_dodge(.9)) +
  geom_text(aes(label = LABELS$Letters, y = Value + 0.2),
            position = position_dodge(0.9),
            vjust = 0,
            color   = "black")

p+labs(title="PFOA", x="Concentration (mg/L)", y = "OD630") + theme_classic(base_size = 14)
ggsave("PFOA tolerance.pdf", height = 3, width = 2.5)
