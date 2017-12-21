source("fasta_to_gc.R")
source("motif_finding.R")
library(seqinr)

# Reads fasta files from  a path containing fasta files (path) or a list of paths (file.list)
# returns a data frame containing : original file, sequence ID, sequence length, gc content,
# number of G/C repeats (of length n). By default G/C repeats are searched without overlap and
# not separately.

fasta_stat <- function(path, file.list, n = 2, overlap = FALSE, separate = FALSE){
  
  tables <- list()
  files <- list()
  fasta <- list()
  name <- c()
  
  if(missing(path) & missing(file.list)){
    stop("no file or directory specified")
  }
  
  if(!missing(path) & !missing(file.list)){
    stop("either enter a path to your file or a file list")
  }
  
  if (!missing(path) & missing(file.list)){
    if(!file.exists(path)){
      stop("no such file or directory")
    }
    else{
      files <- list.files(path, pattern = ".fasta", full.names = T)
      }
    }
  
  if(!missing(file.list) & missing(path)){
    
    for(i in 1:length(file.list)){
      if(!file.exists(file.list[i])){
        stop(paste(file.list[i],": no such file or directory"))
      }
      else{
        files[[i]] <- file.list[i]
      }
    }
  }
  
  for (i in 1:length(files)){
    fasta[[i]] <- read.fasta(files[[i]])
    name[i] <- basename(files[[i]])
    tables[[i]] <- fasta_to_gc(fasta[[i]],overlap)
    file <- c(rep(name[i], nrow(tables[[i]])))
    tables[[i]] <- cbind(file,tables[[i]])
    
    if(!separate){
      nb.dinucleotides <- find_gc(fasta[[i]],n, overlap)
    }
    
    else if(separate){
      nb.dinucleotides <- find_separate_gc(fasta[[i]],n, overlap)
    }
   
    tables[[i]] <- cbind(tables[[i]],nb.dinucleotides)
  }
  
  df <- do.call("rbind", tables)
  return(df)
  
}
