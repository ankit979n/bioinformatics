library(tidyverse)
library(GEOquery)
library(affy)


raw.data<-ReadAffy(celfile.path = "Downloads/")
normalized.data<- rma(raw.data)

normalized.expr <- as.data.frame(exprs(normalized.data))
gse <- getGEO("GSE19826", GSEMatrix = TRUE)

feature.data <- gse$GSE19826_series_matrix.txt.gz@featureData@data
feature.data <- feature.data[,c(1,11)]
normalized.expr <- normalized.expr %>%
  rownames_to_column(var = 'ID') %>%
  inner_join(., feature.data, by = 'ID')



# loads the package
library("writexl")
write_xlsx(normalized.expr,"Downloads\normalized_expr.xlsx")
write.csv(normalized.expr,file = "Result_r.csv")

