#!/bin/bash
#PBS -N prodigal_job
#PBS -l nodes=1:ppn=4
#PBS -l walltime=4:00:00
#PBS -l mem=40gb
#PBS -j oe

# Change to the correct conda
source <path/to/correct/conda.sh>

# Activate environment with prodigal installed
conda activate kofam

# Input parent directory containing all sample directories with assemblies
input_directory=<path/to/sample/directory>

# Output directory for the predicted genes
output_directory=<path/to/prodigal_output>

# Create output directory if it doesn't exist
mkdir -p $output_directory

# Loop through each sample directory, run Prodigal on the assembly files 
for sample_directory in $input_directory/*/; do
    # Get the base name for the sample
    base=$(basename $sample_directory)
    
    # Find the assembly file - we assume there's exactly one *.fasta file directly in each sample directory
    for assembly_file in $sample_directory/*.fasta; do
        # Check if the assembly file exists before running Prodigal
        if [[ -f $assembly_file ]]; then
            # Run Prodigal with both protein (-a) and nucleotide (-d) output
            prodigal -i $assembly_file \
                    -a $output_directory/${base}_proteins.faa \
                    -d $output_directory/${base}_nucleotides.fna \
                    -p meta
        else
            echo "No .fasta file found directly in $sample_directory"
        fi
        # We break after finding the first .fasta file in the sample directory.
        break
    done
done