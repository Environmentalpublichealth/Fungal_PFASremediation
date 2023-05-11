setwd("~/Desktop/Jiali/TAMU/xiaohan/S12/")
library("ggplot2")

annot <- read.csv("genome/S12.emapper.annotations", header = T, skip = 4, sep = "\t")

# count COG category, one gene can be in different categories
for (i in c(1:26)) {
  print(LETTERS[i])
  print(length(annot$COG_category[grep(LETTERS[i],annot$COG_category)]))  
}

COG <- read.csv("data/Gene category.csv", header = T)
goodCOG <- COG[1:23,]
goodCOG <- goodCOG[order(goodCOG$number),]
goodCOG$description <- factor(goodCOG$description, levels = goodCOG$description)
ggplot(data = goodCOG, aes(x=description, y=number, fill=group)) +
  geom_bar(stat = "identity")+
  labs(x="",y="The number of gene models", fill="")+
  coord_flip()+
  scale_fill_manual(values = c("#EFDDB195","#E97D6B95","#81B7A295"))+
  theme_classic()+
  theme(axis.text.y=element_text(colour="black"))
ggsave("img/COG plot.pdf", height = 4.5, width = 11)  
