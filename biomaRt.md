#### First we need to use gene_symbol ('hgnc_symbol') as the searching index. 

```R
data <- top_genes(as.data.table(region[[1]]), n=30)
# genelist <- data$string_gene_symbols
genelist <- c('ERBB2', 'MYC', 'ESR1', 'PGSR')
ensembl <- useMart("ensembl",dataset="hsapiens_gene_ensembl")
filters = listFilters(ensembl)
attributes <- listAttributes(ensembl)
my_ensembl_gene_id <- getBM(attributes==c('ensembl_gene_id', 'hgnc_symbol', 'description', 'gene_biotype'),
                                filters = 'hgnc_symbol',
                                values = genelist,
                                mart = ensembl)
# We want to report 'ensembl_gene_id', 'hgnc_symbol', 'description', 'gene_biotype' as ouptut. 

```

#### Merge back with original data structure 
```R
merged <- merge(data, as.data.table(my_ensembl_gene_id), by="string_gene_symbols", all=T, allow.cartesian=TRUE)
```

#### Create url link for output 
```R
merged$GeneCard <- paste0("<a href='http://www.genecards.org/cgi-bin/carddisp.pl?gene=",
                             merged$string_gene_symbols, "'>", merged$string_gene_symbols, "</a>")
merged$Ensembl <- ifelse(is.na(merged$ensembl_gene_id), NA,
                      paste("<a href='http://useast.ensembl.org/Homo_sapiens/Gene/Summary?g=",
                      merged$ensembl_gene_id, "'>", merged$ensembl_gene_id, "</a>", sep=""))
```

#### Drop unwanted columns and reoder them 
```R
# Drop unwanted columns
merged$ensembl_gene_id <- NULL
merged$string_gene_symbols <- NULL
# Reorder the column order
merged <- merged[order(-Count),]
merged <- as.data.frame(merged)[c(4,2,1,3,5)]
as.data.frame(merged)
```
