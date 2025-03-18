#loading tidyverse, tidyr, and dplyr
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

if (!require("tidyr")) install.packages("tidyr")
library(tidyr)

if (!require("dplyr")) install.packages("dplyr")
library(dplyr)

if (!require("data.table")) install.packages("data.table")
library(data.table)


#MAIZE


#filtering for maize groups ZMMIL, ZMMLR, or ZMMMR
maize_fang_groups <- filter(fang_et_al_genotypes_data, Group %in% c("ZMMIL", "ZMMLR", "ZMMMR"))

#removing label columns from genotype data before transposing
transposable_maize_fang <- select(maize_fang_groups, !Sample_ID & !JG_OTU & !Group)

#creating encoded files with ? (1) and - (2)
transposable_maize_fang_1 <- replace(transposable_maize_fang, transposable_maize_fang == "?/?", "?")
transposable_maize_fang_2 <- replace(transposable_maize_fang, transposable_maize_fang == "?/?", "-")

#converting to data tables for large data analysis
snps_data <- data.table(snps_data)
transposed_maize_fang1 <- data.table(t(transposable_maize_fang_1), keep.rownames = TRUE)
transposed_maize_fang2 <- data.table(t(transposable_maize_fang_2), keep.rownames = TRUE)

setnames(transposed_maize_fang1, "rn", "SNP_ID")
setnames(transposed_maize_fang2, "rn", "SNP_ID")

snps_fang_maize1 <- snps_data[transposed_maize_fang1, on = "SNP_ID"]
snps_fang_maize2 <- snps_data[transposed_maize_fang2, on = "SNP_ID"]


#creating files arranged in ascending order and descending order by position
setorder(snps_fang_maize1, "Chromosome","Position")
setorder(snps_fang_maize2, "Chromosome","Position")


#creating chromosome data files in ascending and decending order
for (i in 1:10) {
  file_name <- paste0("results/snps_fang_maize_ascending_chr", i, ".tsv")
  
  temp_dt <- snps_fang_maize1[Chromosome == as.character(i)]
  
  fwrite(temp_dt, file_name, sep="\t")
  
  cat("Writing file:", file_name, "\n")

}

for (i in 1:10) {
  file_name <- paste0("results/snps_fang_maize_decending_chr", i, ".tsv")
  
  temp_dt <- snps_fang_maize2[Chromosome == as.character(i)]
  
  fwrite(temp_dt, file_name, sep="\t")
  
  cat("Writing file:", file_name, "\n")
  
}



#TEOSINTE - (copy of maize basically)

teosinte_fang_groups <- filter(fang_et_al_genotypes_data, Group %in% c("ZMPBA", "ZMPIL", "ZMPJA"))

#removing label columns from genotype data before transposing
transposable_teosinte_fang <- select(teosinte_fang_groups, !Sample_ID & !JG_OTU & !Group)

#creating encoded files with ? (1) and - (2)
transposable_teosinte_fang_1 <- replace(transposable_teosinte_fang, transposable_teosinte_fang == "?/?", "?")
transposable_teosinte_fang_2 <- replace(transposable_teosinte_fang, transposable_teosinte_fang == "?/?", "-")

#converting to data tables for large data analysis
snps_data <- data.table(snps_data)
transposed_teosinte_fang1 <- data.table(t(transposable_teosinte_fang_1), keep.rownames = TRUE)
transposed_teosinte_fang2 <- data.table(t(transposable_teosinte_fang_2), keep.rownames = TRUE)

setnames(transposed_teosinte_fang1, "rn", "SNP_ID")
setnames(transposed_teosinte_fang2, "rn", "SNP_ID")

snps_fang_teosinte1 <- snps_data[transposed_teosinte_fang1, on = "SNP_ID"]
snps_fang_teosinte2 <- snps_data[transposed_teosinte_fang2, on = "SNP_ID"]


#creating files arranged in ascending order and descending order by position
setorder(snps_fang_teosinte1, "Chromosome","Position")
setorder(snps_fang_teosinte2, "Chromosome","Position")


#creating chromosome data files in ascending and decending order
for (i in 1:10) {
  file_name <- paste0("results/snps_fang_teosinte_ascending_chr", i, ".tsv")
  
  temp_dt <- snps_fang_teosinte1[Chromosome == as.character(i)]
  
  fwrite(temp_dt, file_name, sep="\t")
  
  cat("Writing file:", file_name, "\n")
  
}

for (i in 1:10) {
  file_name <- paste0("results/snps_fang_teosinte_decending_chr", i, ".tsv")
  
  temp_dt <- snps_fang_teosinte2[Chromosome == as.character(i)]
  
  fwrite(temp_dt, file_name, sep="\t")
  
  cat("Writing file:", file_name, "\n")
  
}
