setwd("~/Desktop/Jiali/TAMU/xiaohan/S12/")
install.packages("RIdeogram")

library(RIdeogram)
#### example codes ##########
data(human_karyotype, package="RIdeogram")
data(gene_density, package="RIdeogram")

ideogram(karyotype = human_karyotype, overlaid = gene_density, label = LTR_density, label_type = "heatmap", colorset1 = c("#f7f7f7", "#e34a33"), colorset2 = c("#f7f7f7", "#2c7fb8")) #use the arguments 'colorset1' and 'colorset2' to set the colors for gene and LTR heatmaps, separately.

convertSVG("chromosome.svg", device = "png")

### calculate density #########
repeat_density <- GFFex(input = "genome/S12_ONT.pilon.chr.repeats.gff3", karyotype = "circos/karyotype.txt", feature = "dispersed_repeat", window = 20000)
gene_density <- GFFex(input = "genome/S12.function_filtered.genes.sorted.fixed.gff", karyotype = "circos/karyotype.txt", feature = "mRNA", window = 20000)
##### my own data ############
S12_karyotype <- read.csv("circos/karyotype.csv", header = T)
gene_density <- read.csv("geneDensity.csv", header = T, sep = "\t")
repeat_density <- read.csv("repeatDensity.csv", header = T, sep = "\t")
# pre-process the data to match function required format
S12_karyotype$Chr <- gsub("tig|_pilon","",S12_karyotype$Chr)
S12_karyotype$Chr <- as.numeric(S12_karyotype$Chr)

gene_density$Chr <- as.numeric(gsub("tig|_pilon","",gene_density$Chr))


repeat_density$Chr <- as.numeric(gsub("tig|_pilon","",repeat_density$Chr))

ideogram(karyotype = S12_karyotype, overlaid = gene_density, label = repeat_density, label_type = "heatmap", colorset1 = c("#f7f7f7", "#e34a33"), colorset2 = c("#f7f7f7", "#2c7fb8")) #use the arguments 'colorset1' and 'colorset2' to set the colors for gene and LTR heatmaps, separately.

convertSVG("chromosome.svg", device = "png")
