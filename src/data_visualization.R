if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)


#assumed that this runs after data_processing and inspection.


#Views the counts of Chromosome in the maize file, which correlates with
#how many SNPs are at each Chromosome

ggplot(data = snps_fang_maize1) + geom_bar(mapping=aes(x=Chromosome), color = "navy")
ggsave("SNPs per Chromosome_maize.png", plot = last_plot(), path = "graphs/")

#Repeating for the teosinte

ggplot(data = snps_fang_teosinte1) + geom_bar(mapping=aes(x=Chromosome), color = "navy")
ggsave("SNPs per Chromosome_teosinte.png", plot = last_plot(), path = "graphs/")


#Missing data and amount of heterozygosity

#function that uses chunks to categorize heterozygosity and calculate proportions
# for ggplot2

homozygous_genotypes = c("A/A", "T/T", "G/G", "C/C")

process_chunk <- function(chunk) {
  # Classify each column (genotype) as homozygous, heterozygous, or "?"
  chunk[, paste0(names(chunk), "_genotype") := lapply(.SD, function(x) {
    ifelse(x == "?", "?", ifelse(x %in% homozygous_genotypes, "homozygous", "heterozygous"))
  }), .SDcols = names(chunk)]
  
  # Reshape the data using melt() (for data tables)
  snp_data_melted <- melt(chunk, measure.vars = patterns("genotype"),
                        variable.name = "site", value.name = "genotype")
  
  # Summarize the proportions of each genotype category (homozygous, heterozygous, "?")
  genotype_summary <- snp_data_melted[, .(count = .N), by = genotype]
  genotype_summary[, proportion := count / sum(count)]  # Calculate the proportion
  
  return(genotype_summary)
}



#Chunks are used to process data more efficently

chunk_size <- 4

chunks <- split(snps_fang_maize1, rep(1:ceiling(nrow(snps_fang_maize1)/chunk_size),
              each = chunk_size, length.out = nrow(snps_fang_maize1)))


result_maize <- rbindlist(lapply(chunks, process_chunk))

# Summarize overall proportions from all chunks
final_summary <- result_maize[, .(count = sum(count)), by = genotype]
final_summary[, proportion := count / sum(count)]  # Recalculate overall proportion



# Plot using ggplot2 for maize heterozygosity
ggplot(final_summary, aes(x = genotype, y = proportion, fill = genotype)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("homozygous" = "red", "heterozygous" = "purple", "?" = "gray")) +
  labs(title = "Proportion of Homozygous, Heterozygous, and Missing  for Maize",
       x = "Genotype Category", 
       y = "Proportion")
#Saving graph
ggsave("Proportion of Homozygous, Heterozygous, and Missing  for Maize.png", plot = last_plot(), path = "graphs/")





#Repeating for teosinte

chunks <- split(snps_fang_teosinte1, rep(1:ceiling(nrow(snps_fang_teosinte1)/chunk_size),
                                      each = chunk_size, length.out = nrow(snps_fang_teosinte1)))


result_maize <- rbindlist(lapply(chunks, process_chunk))

# Summarize overall proportions from all chunks
final_summary <- result_maize[, .(count = sum(count)), by = genotype]
final_summary[, proportion := count / sum(count)]  # Recalculate overall proportion



# Plot using ggplot2 for teosinte heterozygosity
ggplot(final_summary, aes(x = genotype, y = proportion, fill = genotype)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("homozygous" = "blue", "heterozygous" = "purple", "?" = "brown")) +
  labs(title = "Proportion of Homozygous, Heterozygous, and Missing  for Teosinte",
       x = "Genotype Category", 
       y = "Proportion")

#Saving graph
ggsave("Proportion of Homozygous, Heterozygous, and Missing  for Teosinte.png", plot = last_plot(), path = "graphs/")






