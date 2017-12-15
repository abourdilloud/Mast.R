library(seqinr)
library(limma)
source("motif_finding.R")

path <- "data"
file <- "data/aa_part.fasta"

# extracts gc stats from fasta file

fasta_to_gc <- function(fasta_file, overlap=FALSE){
  
  name <- strsplit2(fasta_file,"/")
  name <- name[,length(name)]
  
  fasta <- read.fasta(fasta_file)
  
  sequence <- c()
  gc.content <- c()
  length <- c()
  
  for(i in (1:length(fasta))){
    sequence[i] <- attr(fasta[[i]],"name")
    gc.content[i] <- summary(fasta[[i]])$GC
    length[i] <- length(fasta[[i]])
    
  }
  
  df <- data.frame(file=rep(name, length(fasta)), sequence,length, gc.content)
  if (!overlap){
    df$nb.dinucleotides <- find_gc(fasta_file)
  }
  else if(overlap){
    df$nb.dinucleotides <- find_gc(fasta_file,TRUE)
  }
  
 
  return(df)
}

df <- fasta_to_gc(file, overlap=TRUE)



fasta_to_gc <- function(path, overlap=FALSE){
  
  if(!file.exists(path)){
    return(paste(path,": no such file or directory"))
  }
  
  else{
    files <- list.files(path, pattern=".fasta")
    return(files)
    
  }
}
