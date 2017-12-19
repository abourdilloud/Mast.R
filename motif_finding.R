library(seqinr)

##reads fasta file and returns nb of dinucleotides (default without overlap)

find_gc <- function(fasta, overlap=FALSE){
  
  nb.gc <- c()
  
  for (i in 1:length(fasta)){
    
    sequence <- paste(fasta[[i]],collapse = "")
    
    if (!overlap){
      nb.gc[i] <- length(gregexpr("[GCgc]{2}", sequence , perl = TRUE)[[1]])
    }
    
    else if(overlap){
      nb.gc[i] <- length(gregexpr("(?=[GCgc]{2})", sequence , perl = TRUE)[[1]])
    }
  }
  
  return(nb.gc)
}

find_separate_gc <- function(fasta, overlap=FALSE){
  nb.GG <- c()
  nb.GC <- c()
  nb.CC <- c()
  nb.CG <- c()
  
  for (i in 1:length(fasta)){
    sequence <- paste(fasta[[i]],collapse = "")
    
    if(!overlap){
      nb.GG[i] <- length(gregexpr("GG", sequence , perl = T, ignore.case = T)[[1]])
      nb.GC[i] <- length(gregexpr("GC", sequence , perl = T, ignore.case = T)[[1]])
      nb.CC[i] <- length(gregexpr("CC", sequence , perl = T, ignore.case = T)[[1]])
      nb.CG[i] <- length(gregexpr("CG", sequence , perl = T, ignore.case = T)[[1]])
    }
    
    else if(overlap){
      nb.GG[i] <- length(gregexpr("(?=(GG))", sequence , perl = T, ignore.case = T)[[1]])
      nb.GC[i] <- length(gregexpr("(?=(GC))", sequence , perl = T, ignore.case = T)[[1]])
      nb.CC[i] <- length(gregexpr("(?=(CC))", sequence , perl = T, ignore.case = T)[[1]])
      nb.CG[i] <- length(gregexpr("(?=(CG))", sequence , perl = T, ignore.case = T)[[1]])
    }
  }
  
  nb <- data.frame(nb.GG, nb.GC, nb.CC, nb.CG)
  return(nb)
}

