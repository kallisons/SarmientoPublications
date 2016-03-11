coauthors<-read.csv("~/Code/Projects/SarmientoPublications/data/SarmientoNetwork2.csv", stringsAsFactors=FALSE, header=FALSE)

coauthors[coauthors==""]<-NA

coauthors<-subset(coauthors, is.na(coauthors[,2])==FALSE)
coauthors<-subset(coauthors, is.na(coauthors[,6])==TRUE)


authors<-unique(unlist(coauthors))
authors<-subset(authors, is.na(authors)==FALSE)
authors<-sort(authors)

network<-as.data.frame(matrix(NA, 1, 3))
colnames(network)<-c("source", "target", "value")

for(i in 1:nrow(coauthors)){
	paper<-unlist(coauthors[i,])
	paper<-subset(paper, is.na(paper)==FALSE)
	paper<-sort(paper)
	pairs<-combn(paper,2)
	for(j in 1:ncol(pairs)){
		sourcei<-which(authors==pairs[1,j])
		targeti<-which(authors==pairs[2,j])		
		exists<-which(network$source==sourcei & network$target==targeti)
		if(length(exists)==0){
			network<-rbind(network, setNames(c(sourcei, targeti, 1), c("source", "target", "value")))
			}else{
			network$value[exists]<-network$value[exists]+1
			}
		}
		
	}
network<-network[-1,]	

network2<-subset(network, network$source!=111 & network$target!=111)


#Network with Jorge

#convert links so that 0 refers to the first element
network$source<-network$source-1
network$target<-network$target-1

authors<-as.data.frame(authors, stringsAsFactors=FALSE)
authors$group<-rep(NA)	
authors$group<-ifelse(authors$authors=="Sarmiento", 1, 2)
authors$col1<-paste("{\"name\":\"", authors$authors, "\"", sep="")
authors$col2<-paste("\"group\":", authors$group, "},", sep="")
authors<-authors[,c("col1", "col2")]

outfile<-"~/Code/Projects/SarmientoPublications/nodes.json"
write.table(authors, outfile, quote=FALSE, sep=",", row.names=FALSE, col.names=FALSE)


network$col1<-paste("{\"source\":", network$source, sep="")
network$col2<-paste("\"target\":", network$target, sep="")
network$col3<-paste("\"value\":", network$value, "},", sep="")
network<-network[,c("col1", "col2", "col3")]


outfile2<-"~/Code/Projects/SarmientoPublications/links.json"
write.table(network, outfile2, quote=FALSE, sep=",", row.names=FALSE, col.names=FALSE)

#Network without Jorge
network2$source<-network2$source-1
network2$target<-network2$target-1

network2$col1<-paste("{\"source\":", network2$source, sep="")
network2$col2<-paste("\"target\":", network2$target, sep="")
network2$col3<-paste("\"value\":", network2$value, "},", sep="")
network2<-network2[,c("col1", "col2", "col3")]

outfile3<-"~/Code/Projects/SarmientoPublications/links2.json"
write.table(network2, outfile3, quote=FALSE, sep=",", row.names=FALSE, col.names=FALSE)


	