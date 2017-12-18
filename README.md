# Mast.R

Data analysis project : Mast.R 
This project is to analyse fasta sequences and do some stats on GC content.

Functions : 

1. fasta_stat() : main function, takes a list of fasta files (or a path to a directory containing fasta files) and returns a dataframe with stats (by default the data frame is the one returned by fasta_to_gc)

2. fasta_to_gc() : reads fasta file, creates a dataframe with basic info (sequence identifier, gc content, sequence length) and the number of dinucleotides per sequence (by default without overlap)

2. find_gc() : A function that finds GC dinucleotides (diNT) and return their number and position in the sequence. 

To do : 
- decide whether it makes sense to include an overlap option
- option to separate the diNT cases or not
- GC position or spacing ? Store all position/spacing or a mean and variance per sequence ?

3. A function that finds a specific pattern and return its number and position in the sequence. 

To do : see 2. 

4. A function that returns a plot for the desired stats. 
To do : everything.
