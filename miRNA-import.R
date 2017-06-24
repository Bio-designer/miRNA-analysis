##import all the mature miRNA sequence and extract items of interest


##import the file download from miRBase
mature_Mu<-scan("your path of the miRNA sequence fasta file",
          sep="\n",what=character(),blank.lines.skip = FALSE)

##to transform the row file into a matrix with two columns
miRNA_mtx<-matrix(data=mature_Mu, length(mature_Mu)/2,byrow=TRUE)

miRNA_set<-as.data.frame(miRNA_mtx)

colnames(miRNA_set)<-c("miRNA","sequence")

##transform miRNA name
miRNA_set$miRNA<-gsub(">","",miRNA_set$miRNA)

##suppose miRNA_chosen is a character vector of the miRNAs of interest
miRNA_chose<-c("mmu-miR-xxx","mmu-miR-xx","mmu-miR-x")

##filter the miRNA and its sequence by the names on your list
miRNA_out<-miRNA_set[which(miRNA_set$miRNA %in% miRNA_chosen ),]


##output your chosen miRNA and its sequence
write.table(miRNA_out,file="your output path",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)
