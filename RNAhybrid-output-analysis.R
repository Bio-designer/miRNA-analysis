##Since RNAhybrid output is listed row by row and not easy to rank by the MFE
##The code below is designed to solve this problem

##read from output file process by RNAhybrid
raw<-scan("your path of the output file",
 sep="\n",what=character(),blank.lines.skip = FALSE)


##transform into a matrix
mtx<-matrix(data=raw, length(raw)/15,byrow=TRUE)


df<-as.data.frame(mtx)

##transform MFE
df[,6]<-gsub("mfe: ","",df[,6])
df[,6]<-gsub(" kcal/mol","",df[,6])
df[,6]<-as.numeric(df[,6])

##transform gene name
df[,1]<-gsub("target: ","",df[,1])

##transform miRNA name
df[,3]<-gsub("miRNA : ","",df[,3])

##transform gene seuqence's length
df[,2]<-gsub("length: ","",df[,2])
df[,2]<-as.numeric(df[,2])

##transform miRNA's length
df[,4]<-gsub("length: ","",df[,4])
df[,4]<-as.numeric(df[,4])

##transform p-value
df[,7]<-gsub("p-value: ","",df[,7])
df[,7]<-as.numeric(df[,7])

##transform position
df[,9]<-gsub("position  ","",df[,9])
df[,9]<-as.numeric(df[,9])

df<-df[,-c(5,8,10:15)]

colnames(df)<-c("gene","gene length","miRNA","miRNA length","MFE","p-value","position")

##rank the whole data frame by MFE
df_order<-df[order(df$MFE),]


##dfc is filtered by MFE threshold
dfc<-df_order[which(df_order$MFE < -30), ]

##check which miRNAs target most of your candidate genes with low MFE
dfc$miRNA
miRNA_good<-table(dfc$miRNA)
miRNA<-as.data.frame(miRNA_good)
miRNA<-miRNA[order(-miRNA$Freq),]

colnames(miRNA)<-c("miRNA","frequency")
miRNA$miRNA<-as.character(miRNA$miRNA)
miRNAc<-miRNA[1:30,]


##to choose rows of which the miRNA is in the list of miRNAc(most frequently appeared)
dfcc<-dfc[which(dfc$miRNA %in% miRNAc[,1]),]

dfcc<-table(dfcc$gene,dfcc$miRNA)
#change the class attribute to "matrix"
attributes(dfcc)$class<-"matrix"

##to roughly check the relationship between the above miRNAs and gene candidates
heatmap(dfcc)
