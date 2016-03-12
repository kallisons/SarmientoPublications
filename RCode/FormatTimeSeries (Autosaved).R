pubdata<-read.csv("~/Code/Projects/SarmientoPublications/data/SarmientoPublications2.csv", header=FALSE)

pubdata[pubdata==""]<-NA

journals<-pubdata[,c(1,2)]

disciplines<-pubdata[,c(1,3)]

elements<-pubdata[,c(1,4:ncol(pubdata))]

years<-seq(min(pubdata[,1]), max(pubdata[,1]), 1)

for(i in 1:){
	
	
	
	
	
}