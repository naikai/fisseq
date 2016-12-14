# Practice from annotation workflow 

http://www.bioconductor.org/help/workflows/annotation/annotation/

# Exercises for AnnotationHub.

###### Exercise 1: Use the AnnotationHub to extract UCSC data that is from Homo sapiens and also specifically from the hg19 genome. What happens to the hub object as you filter data at each step?  
ah <- AnnotationHub()  
orgs <- subset(ah, ah$rdataclass == "OrgDb")  
human <- orgs[['AH46992']]  
select(human, keys=c("105377632","808233"), columns=c("SYMBOL","REFSEQ"), keytype="ENTREZID")


###### Exercise 2 Now that you have basically narrowed things down to the hg19 annotations from UCSC genome browser, lets get one of these annotations. Find the oreganno track and save it into a local variable.  

