library(seqinr)

path = "./data"

listfasta <- list()
list.files(path)


test <- read.fasta("data/aa_part.fasta")
gc <- c()
for(i in 1:length(test)){
  gc[i] <- summary(test[[i]])$GC
}

boxplot(gc)
test$`3`

attr(test[[1]],"name")
