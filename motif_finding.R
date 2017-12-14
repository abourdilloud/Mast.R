library(seqinr)

##reads fasta file and returns nb of dinucleotides (default without overlap)

find_gc <- function(fasta_file, overlap=FALSE){
  fasta <- read.fasta(fasta_file,as.string = T)
  nb.gc <- c()
  
  if(overlap==FALSE){
    for (i in 1:length(fasta)){
      nb.gc[i] <- length(gregexpr("[GCgc]{2}", fasta[[i]] , perl = TRUE)[[1]])
    }
  }
  else{
    for (i in 1:length(fasta)){
      nb.gc[i] <- length(gregexpr("(?=[GCgc]{2})", fasta[[i]] , perl = TRUE)[[1]])
    }
  }
  return(nb.gc)
}

