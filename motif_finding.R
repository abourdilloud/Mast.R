library(seqinr)

#reads fasta file and returns nb of hits (CG repeats with desired length) 
#with or without overlap

find_gc <- function(fasta, n = 2, overlap = FALSE){
  
  nb.gc <- c()
  
  if(!overlap){
    regex <- paste0("[GC]{",n,"}")
  }
  else if(overlap){
    regex <- paste0("(?=[GC]{",n,"})")
  }
  
  for (i in 1:length(fasta)){
    
    sequence <- paste(fasta[[i]],collapse = "")
    if(gregexpr(regex, sequence , perl = T, ignore.case = T)[[1]][1]!=-1){
      nb.gc[i] <- length(gregexpr(regex, sequence , ignore.case = T, perl = T)[[1]])
    }
    else{
      nb.gc[i] <- 0
    }
  }
  return(nb.gc)
}

#reads fasta file and returns nb of hits (CG repeats with desired length (2 or 3)) 
#separate counts by sequence, with or without overlap

find_separate_gc <- function(fasta, n=2, overlap=FALSE){
  if (n!=2 && n!=3){
    stop("length can be either 2 or 3")
  }
  if (n==2){
    u <- c("CC", "CG", "GC", "GG") 
  }
  if (n==3){
    u <- c("CCC", "CCG", "CGC", "CGG", "GCC", "GCG", "GGC", "GGG")
  }
  
  nb <- list()
  col.names <- c()
  
  for (i in 1:length(u)){
    nb.s <- c()
    if(!overlap){
      regex <- u[i]
    }
    else if(overlap){
      regex <- paste0("(?=(",u[i],"))")
    }
    for (j in 1:length(fasta)){
      sequence <- paste(fasta[[j]],collapse = "")
      if(gregexpr(regex, sequence , perl = T, ignore.case = T)[[1]][1]!=-1){
        nb.s[j] <- length(gregexpr(regex, sequence, ignore.case = T, perl = T)[[1]])
      }
      else{
        nb.s[j] <- 0
      }
    }
    col.names[i] <- paste0("nb.", u[i])
    nb[[i]] <- nb.s
  }
  nb.df <- do.call("cbind", nb)
  colnames(nb.df) <- col.names
  return(nb.df)
  
}






