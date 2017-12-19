library(seqinr)
source("motif_finding.R")

# reads fasta file, creates a dataframe with basic info (sequence identifier, gc content, 
# sequence length) and the number of dinucleotides per sequence (by default without overlap)

fasta_to_gc <- function(fasta, overlap=FALSE){
  
  sequence <- c()
  gc.content <- c()
  length <- c()

  for(i in (1:length(fasta))){
    sequence[i] <- attr(fasta[[i]],"name")
    gc.content[i] <- summary(fasta[[i]])$GC
    length[i] <- length(fasta[[i]])
  }
  
  df <- data.frame(sequence, length, gc.content)
  if (!overlap){
    df$nb.dinucleotides <- find_gc(fasta_file)
  }
  else if(overlap){
    df$nb.dinucleotides <- find_gc(fasta_file,TRUE)
  }
  
  return(df)
}

