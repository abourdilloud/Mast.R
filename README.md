# Mast.R

Data analysis project : Mast.R 
This project is to analyse fasta sequences and do some stats on GC content and stuff. Great description. 

Functions : 

1. Main function that reads a list of fasta files and creates a dataframe with basic info (file name, sequence identifier, sequence length). By default it will also include the GC content, and GC dinucleotide number and position per sequence.
To do : 
- transform the existing function to read multiple fasta files (instead of one at a time)

2. find_gc() : A function that finds GC dinucleotides (diNT) and return their number and position in the sequence. 

To do : 
- decide whether it makes sense to include an overlap option
- option to separate the diNT cases or not
- GC position or spacing ? Store all position/spacing or a mean and variance per sequence ?

3. A function that finds a specific pattern and return its number and position in the sequence. 

To do : see 2. 

4. A function that returns a plot for the desired stats. 
To do : everything.