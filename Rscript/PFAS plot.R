setwd("~/Desktop/Jiali/TAMU/xiaohan/S12/data/")

library(ggplot2)
library(plyr)
library(reshape2)
library(Rmisc)

data1 <- read.csv("data-1-04052023.csv", header = T)
# normalized value with an average of control measurement PFOS: 57.247, PFOA:86.740 
data1$Pct <- c(data1[grep("PFOS", data1$Treatment),]$Value / 57.247 * 100, data1[grep("PFOA", data1$Treatment),]$Value/ 86.740 *100)

datasum <- summarySE(data1, measurevar = "Pct", groupvars = c("Day","Treatment"))
PFOA <- datasum[grep("PFOA",datasum$Treatment),]
PFOS <- datasum[grep("PFOS",datasum$Treatment),]
ggplot(data = PFOS[-c(9:10),], aes(x=Day, y=Pct, color=Treatment, group=Treatment))+
  geom_point(size=2) + 
  geom_errorbar(aes(ymin=Pct-sd, ymax=Pct+sd), width=1)+
  geom_line(position = position_dodge(0.1))+
  ylim(1,130)+ xlim(0,60)+
  scale_color_manual(values = c("#202538", "#897553"))+
  labs(x="Time (days)", y ="PFAS %")+
  theme_classic(base_size = 14)
ggsave("PFOS LCMSplot.pdf", height = 3, width = 5)

ggplot(data = PFOA[-c(9:10),], aes(x=Day, y=Pct, color=Treatment, group=Treatment))+
  geom_point(size=2) + 
  geom_errorbar(aes(ymin=Pct-sd, ymax=Pct+sd), width=1)+
  geom_line(position = position_dodge(0.1))+
  ylim(1,130)+ xlim(0,60)+
  scale_color_manual(values = c("#202538", "#897553"))+
  labs(x="Time (days)", y ="PFAS %")+
  theme_classic(base_size = 14)
ggsave("PFOA LCMSplot.pdf", height = 3, width = 5)
