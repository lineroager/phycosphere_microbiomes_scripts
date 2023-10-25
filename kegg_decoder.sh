#!/bin/bash
#PBS -N kegg-decoder
#PBS -l nodes=1:ppn=10:thinnode
#PBS -l mem=64gb
#PBS -l walltime=10:00:00
#PBS -j oe

# Activate the correct conda environment
source /home/projects/dtu_00055/people/linroa/mambaforge/etc/profile.d/conda.sh
conda activate keggdecoder

# Run KEGG decoder
KEGG-decoder -i /home/projects/dtu_00055/data/GhostKOALA_output/all_ko.txt -o kegg_decoder_out --vizoption static