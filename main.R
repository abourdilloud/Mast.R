source("fasta_to_gc.R")
source("motif_finding.R")


fasta_stat <- function(path, file.list, overlap=FALSE){
  
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
  }
  
  df <- do.call("rbind", tables)
  return(df)
  
}
