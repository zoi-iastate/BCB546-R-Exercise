
#loading tidyverse
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)



#importing only the first 3 lines of the snps_position.txt since our data processing only focuses on those columns.
snps_data <- read_tsv("data/snp_position.txt", col_select = c(SNP_ID, Chromosome, Position))


#importing all data from fang_et_al_genotypes.txt
fang_et_al_genotypes_data <- read_tsv("data/fang_et_al_genotypes.txt")

#prove that both files are data frames
print("Is snp_position.txt a data frame?")
print(is.data.frame(snps_data))

print("Is fang_et_al_genotypes.txt a data frame?")
is.data.frame(fang_et_al_genotypes_data)


#Look at column and row size

print("Looking at rows x columns for snps_data")
print(dim(snps_data))


print("Looking at rows x columns for fang_et_al_genotypes.txt")
print(dim(fang_et_al_genotypes_data))
