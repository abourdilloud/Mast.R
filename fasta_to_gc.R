library(seqinr)
source("motif_finding.R")

# creates a dataframe with basic info (sequence identifier, gc content, 
# sequence length) 


seq_to_table <- function(seq_object, method = c("GC","pattern"), pattern,
                        overlap=FALSE, separate=FALSE, n=2){
  tables <- list()
  
  for (i in (1:length(seq_object))){
    seq.ID <- attr(seq_object[[i]],"name")
    gc.content <- summary(seq_object[[i]])$GC
    length <- length(seq_object[[i]])
    seq.as.string <- paste(seq_object[[i]], collapse = "")
    
    tables[[i]] <- data.frame(seq.ID, length, gc.content)
    
    if (missing(method)||method=="gc.content"){
      tables[[i]] <- tables[[i]]
    }
    else if(method=="GC" && !separate){
      tables[[i]] <- cbind(tables[[i]],find_gc(seq.as.string, n, overlap))
    }
    else if(method=="GC" && separate){
      tables[[i]] <- cbind(tables[[i]], find_separate_gc(seq.as.string, n, overlap))
    }
    # else if(method=="pattern" && !missing(pattern)){
    #   tables[[i]] <- cbind(tables[[i]], find_motif(pattern, seq.as.string, overlap))
    # }
  }
  df <- do.call("rbind", tables)
  
  return(df)
}
