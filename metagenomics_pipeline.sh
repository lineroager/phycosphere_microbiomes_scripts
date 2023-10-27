#!/bin/bash
#PBS -N metagenomics_pipeline
#PBS -l nodes=1:fatnode:ppn=40
#PBS -l walltime=48:00:00
#PBS -l mem=300gb
#PBS -j oe

# Load modules
module load tools metagenome-atlas/2.15.2

# Set conda channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Main command to run atlas qc
atlas run qc \
    --working-dir <path/to/sample/files> \
    -c <path/to/config/file/config.yaml> \
    --conda-prefix <path/to/correct/conda/envs>

# Run atlas assembly
atlas run assembly \
    --working-dir <path/to/sample/files> \
    -c <path/to/config/file/config.yaml>\
    --conda-prefix <path/to/correct/conda/envs> \
    --resources mem=295
