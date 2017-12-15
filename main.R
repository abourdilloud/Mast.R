source("fasta_to_gc.R")
source("motif_finding.R")


fasta_stat <- function(path, file.list){
  
  tables <- list()
  
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
      for(i in 1:length(files)){
        tables[[i]] <- fasta_to_gc(files[[i]])
      }
    }
  }
  
  if(!missing(file.list) & missing(path)){
    
    for(i in 1:length(file.list)){
      if(!file.exists(file.list[i])){
        stop(paste(file.list[i],": no such file or directory"))
      }
      else{
        tables[[i]] <- fasta_to_gc(file.list[[i]])
      }
    }
  }
  
  table <- do.call("rbind",tables)
  return(table)
}
