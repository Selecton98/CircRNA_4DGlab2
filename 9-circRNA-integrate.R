library(tidyr)
library(VennDiagram)
library(dplyr)
library(tidyr)
circRNA_finder.s<-read.table('./circfinder/H1_circfinder_outH1s_filteredJunctions.bed',sep = '\t',header=FALSE)
CIRI2.s<-read.table('./CIRI/H1.CIRI.txt',sep = '\t',header=FALSE)
find_circ.s<-read.table('./findcirc/H1.sites.bed',sep = '\t',header=FALSE)
circexplorer.s<-read.table('./circexplorer/H1CIRCexplorer_circ.txt',sep = '\t',header=FALSE)
circRNA_finder.n<-unite(circRNA_finder.s,"circ",V1,V2,V3,V6,sep = "_")
CIRI2.s$V3<-CIRI2.s$V3-1
CIRI2.n<-unite(CIRI2.s,"circ",V2,V3,V4,V11,sep = "_")
find_circ.n<-unite(find_circ.s,"circ",V1,V2,V3,V6,sep = "_")
circexplorer.n<-unite(circexplorer.s,"circ",V1,V2,V3,V6,sep = "_")
circRNA_finder.n<<-dplyr::filter(circRNA_finder.n, grepl("chr",circ))
CIRI2.n<<-dplyr::filter(CIRI2.n, grepl("chr",circ))
find_circ.n<<-dplyr::filter(find_circ.n, grepl("chr",circ))
circexplorer.n<<-dplyr::filter(circexplorer.n, grepl("chr",circ))
circexplorer.v<-circexplorer.n[,c("circ","V13")]
CIRI2.v<-CIRI2.n[,c("circ","V5")]
circRNA_finder.v<-circRNA_finder.n[,c("circ","V5")]
find_circ.v<-find_circ.n[,c("circ","V5")]
colnames(circRNA_finder.v)<-c("circ","circfind")
colnames(CIRI2.v)<-c("circ","CIRI")
colnames(find_circ.v)<-c("circ","findcirc")
colnames(circexplorer.v)<-c("circ","circexp")
circRNA_finder.v<-circRNA_finder.v %>% group_by(circ) %>% summarise_each(funs(mean)) 
CIRI2.v<-CIRI2.v %>% group_by(circ) %>% summarise_each(funs(mean)) 
find_circ.v<-find_circ.v %>% group_by(circ) %>% summarise_each(funs(mean)) 
circexplorer.v<-circexplorer.v %>% group_by(circ) %>% summarise_each(funs(mean))
input<-list(circRNA_finder.v$circ,CIRI2.v$circ,find_circ.v$circ,circexplorer.v$circ)
Table<-calculate.overlap(input)

venn<-venn.diagram(input,NULL, main.cex = 2,
                   category = c("circRNA_finder", "CIRI2", "find_circ","circexplorer"),fill = c("red","navy","lightgrey","orange"),
                   cat.col= c("red","navy","grey","orange"),   imagetype = "tiff",  main.fontfamily="serif") 
pdf("H1.pdf")
grid.draw(venn)
dev.off()
mer1<-merge(circRNA_finder.v,CIRI2.v,all=T)
mer2<-merge(mer1,find_circ.v,all=T)
mer3<-merge(mer2,circexplorer.v,all=T)
dim(mer3)
length(unique(mer3$circ))
mer3[is.na(mer3)]<-0
rownames(mer3)<-mer3$circ
mer3$circ<-NULL
quantile(rowSums(as.matrix(mer3)> 0),0.9)
quantile(rowSums(as.matrix(mer3)> 0),0.99)
quantile(rowSums(as.matrix(mer3)> 0),0.9999)
quantile(rowSums(as.matrix(mer3)> 0),0.99999)
mer4<-mer3[rowSums(as.matrix(mer3)>0)>1,]
mer4$sum<-rowSums(as.matrix(mer4)>0)
mer4$count<-rowSums(mer4[,c(1,2,3,4)])
mer4$result<-mer4$count/mer4$sum
write.csv(mer4,"H1.csv")
