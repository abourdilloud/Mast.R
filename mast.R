setwd("~/UNIGE/Stats & Proba/DAP")

require(seqinr)

path = "./data"

listfasta <- list()
list.files(path)


test <- read.fasta("fasta_test.fasta")
gc <- c()
for(i in 1:length(test)){
  gc[i] <- summary(test[[i]])$GC
}

boxplot(gc)
