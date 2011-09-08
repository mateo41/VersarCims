args<-commandArgs()

datafile<-args[6]
directory<-args[7]
var<-args[8]
plotnumber<-args[9]
cv<-read.csv(datafile)
plotfilename<- sprintf("%s\\%s%s%s", directory,"plots",plotnumber ,".jpg")
title<-paste("Scatterplot of ", var, " in versar and cims datasets")

jpeg(plotfilename, height=352, width=480)
plot(cv$cimsvalue, cv$versarvalue, xlab="cims values", ylab="versar values",
     main=title)


dev.off()

cc<-cor(cv$cimsvalue, cv$versarvalue)
outputfilename<-sprintf("%s\\%s", directory,"cc.txt")
write.csv(cc,outputfilename)

