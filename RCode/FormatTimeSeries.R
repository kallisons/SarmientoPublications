pubdata<-read.csv("~/Code/Projects/SarmientoPublications/data/SarmientoPublications3.csv", header=FALSE, stringsAsFactors=FALSE)

pubdata[pubdata==""]<-NA

allyears<-seq(min(pubdata[,1]), max(pubdata[,1]), 1)

journals<-pubdata[,c(1,2)]
journalsum<-as.data.frame.matrix(table(journals))
journaltotals<-apply(journalsum, MARGIN=2, sum)
makeother<-journalsum[which(journaltotals<=5)]
othertotals<-apply(makeother, MARGIN=1, sum)
journalsum<-journalsum[which(journaltotals>5)]
journalsum<-cbind(journalsum, othertotals)
colnames(journalsum)[ncol(journalsum)]<-"Other"
journalsum<-cbind(row.names(journalsum), journalsum)
colnames(journalsum)[1]<-"date"
rownames(journalsum)<-c()
allyears<-as.data.frame(allyears)
colnames(allyears)<-"date"
journalsall<-merge(allyears, journalsum, by="date", all=TRUE)
journalsall[is.na(journalsall)==TRUE]<-0
journalsall<-journalsall[,c("date", "Journal of Physical Oceanography", "Earth and Planetary Science Letters", "Geophysical Research Letters", "Journal of Geophysical Research", "Tellus", "Biogeosciences", "Global Biogeochemical Cycles", "Nature", "Science", "Book", "Other")]


for(a in 2:ncol(journalsall)){	
	if(a==2){
		jformat<-journalsall[,c(1,a)]
		colnames(jformat)<-c("date", "value")
		jformat$key<-rep(colnames(journalsall)[a])		
	}else{
	jadd<-journalsall[,c(1,a)]
	colnames(jadd)<-c("date", "value")
	jadd$key<-rep(colnames(journalsall)[a])
	jformat<-rbind(jformat, jadd)}
}

jformat<-jformat[,c("key", "value", "date")]
outfile.j<-paste("~/Code/Projects/SarmientoPublications/journalts.csv")
write.table(jformat, outfile.j, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)


disciplines<-pubdata[,c(1,3)]
discipsum<-as.data.frame.matrix(table(disciplines))
discipsum$Other<-discipsum$Economics+discipsum$Policy+discipsum$Statistics
discipsum<-cbind(row.names(discipsum), discipsum[,c("Physical", "Chemical", "Biological", "Other")])
colnames(discipsum)[1]<-"date"
rownames(discipsum)<-c()
allyears<-as.data.frame(allyears)
colnames(allyears)<-"date"
discipall<-merge(allyears, discipsum, by="date", all=TRUE)
discipall[is.na(discipall)==TRUE]<-0
#outfile.d<-paste("~/Code/Projects/SarmientoPublications/disciplinets.tsv")
#write.table(discipall, outfile.d, quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)

for(a in 2:ncol(discipall)){	
	if(a==2){
		dformat<-discipall[,c(1,a)]
		colnames(dformat)<-c("date", "value")
		dformat$key<-rep(colnames(discipall)[a])		
	}else{
	dadd<-as.data.frame(discipall[,c(1,a)])
	colnames(dadd)<-c("date", "value")
	dadd$key<-rep(colnames(discipall)[a])
	dformat<-rbind(dformat, dadd)}
}

dformat<-dformat[,c("key", "value", "date")]

outfile.d2<-paste("~/Code/Projects/SarmientoPublications/disciplinets.csv")
write.table(dformat, outfile.d2, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)


elements<-pubdata[,c(1,4:ncol(pubdata))]
elementfind<-elements[,1:2]
elementfind<-subset(elementfind, is.na(elementfind[,2])==FALSE)
colnames(elementfind)<-c("year", "element")
for(i in 3:ncol(elements)){
	hold<-elements[,c(1,i)]
	colnames(hold)<-c("year", "element")
	hold<-subset(hold, is.na(hold[,2])==FALSE)
	elementfind<-rbind(elementfind, hold)	
}

elementsum<-as.data.frame.matrix(table(elementfind))
elementtotals<-apply(elementsum, MARGIN=2, sum)
makeother<-elementsum[which(elementtotals<10)]
othertotals<-apply(makeother, MARGIN=1, sum)
elementsum<-elementsum[which(elementtotals>=10)]
elementsum<-cbind(elementsum, othertotals)
colnames(elementsum)[ncol(elementsum)]<-"other"
elementsum<-cbind(row.names(elementsum), elementsum)
colnames(elementsum)[1]<-"date"
rownames(elementsum)<-c()
allyears<-as.data.frame(allyears)
colnames(allyears)<-"date"
elementsall<-merge(allyears, elementsum, by="date", all=TRUE)
elementsall[is.na(elementsall)==TRUE]<-0
elementsall<-elementsall[,c("date", "CFC", "carbon-14", "carbon dioxide", "carbon", "nitrogen", "nitrate", "oxygen", "iron", "calcium carbonate", "silicon", "chlorophyll", "phytoplankton", "fish", "other")]

for(a in 2:ncol(elementsall)){	
	if(a==2){
		eformat<-elementsall[,c(1,a)]
		colnames(eformat)<-c("date", "value")
		eformat$key<-rep(colnames(elementsall)[a])		
	}else{
	eadd<-elementsall[,c(1,a)]
	colnames(eadd)<-c("date", "value")
	eadd$key<-rep(colnames(elementsall)[a])
	eformat<-rbind(eformat, eadd)}
}

eformat<-eformat[,c("key", "value", "date")]
outfile.e<-paste("~/Code/Projects/SarmientoPublications/elementts.csv")
write.table(eformat, outfile.e, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)




