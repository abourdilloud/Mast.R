library(seqinr)

# returns number of G/C repeats of size n (default n=2) and with 
# or without overlap (default without), not separated by cases

find_gc <- function(dna_seq, n = 2, overlap = FALSE){
  
  if(!overlap){
    regex <- paste0("[GC]{",n,"}")
  }
  if(overlap){
    regex <- paste0("(?=[GC]{",n,"})")
  }
  
  if(gregexpr(regex, dna_seq , perl = T, ignore.case = T)[[1]][1]!=-1){
    nb.gc <- length(gregexpr(regex, dna_seq, ignore.case = T, perl = T)[[1]])
  }
  else if(gregexpr(regex, dna_seq , perl = T, ignore.case = T)[[1]][1]==-1){
    nb.gc <- 0
  }
  return(nb.gc)
}

# returns number of G/C repeats of size 2 (default) or 3 and with
# or without overlap (default without), separated by cases

find_separate_gc <- function(dna_seq, n=2, overlap=FALSE){
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
    if(overlap){
      regex <- paste0("(?=(",u[i],"))")
    }
    
    if(gregexpr(regex, dna_seq , perl = T, ignore.case = T)[[1]][1]!=-1){
      nb.s <- length(gregexpr(regex, sequence, ignore.case = T, perl = T)[[1]])
    }
    if(gregexpr(regex, dna_seq , perl = T, ignore.case = T)[[1]][1]==-1){
      nb.s <- 0
    }
    col.names[i] <- paste0("nb.", u[i])
    nb[[i]] <- nb.s
  }
  nb.df <- do.call("cbind", nb)
  colnames(nb.df) <- col.names
  return(nb.df)
  
}
# Search for a specific motif in a sequence and output the number of occurences.
find_motif <- function(motif, dna_seq, overlap = TRUE){
  
  occ_count <- 0
  mean_space <- 0
  
  if (overlap == TRUE) {
    
    mot_string <- paste('(?=(', motif, '))', sep = '')
    
  } else if (overlap == FALSE) {
    
    mot_string <- paste('(', motif, ')', sep = '')
    
  }
  
  mot_match <- gregexpr(mot_string, dna_seq, perl = TRUE)
  
  if (mot_match[[1]][1] != -1) {
    
    occ_count <- length(mot_match[[1]])
    
    if (length(mot_match[[1]]) > 1){
      
      for (i in seq(length(mot_match[[1]])-1)){
        
        mean_space <- mean_space + (as.vector(mot_match[[1]])[i+1] - as.vector(mot_match[[1]])[i] - nchar(motif))
        
      }
      
      mean_space <- mean_space/(length(mot_match[[1]])-1)
      
    }
  }
  
  return(c(occ_count, round(mean_space, 3)))
}











