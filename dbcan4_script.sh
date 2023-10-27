#!/bin/bash

#PBS -N dbCAN4_job
#PBS -l nodes=1:thinnode:ppn=15
#PBS -l walltime=24:00:00
#PBS -l mem=100gb  
#PBS -j oe

# Load conda environment
source <path/to/correct/conda.sh>
conda activate run_dbcan

# Run dbcan4 pipeline on all samples

cd <path/to/working/dir/for/dbcan4/>

for sample_prefix in CwM IgM TsM
do
    for i in {1..4}
    do
        sample_folder=<path/to/folders/with/assemblies/${sample_prefix}${i}
        if [ -d $sample_folder ]
        then
            for assembly in $sample_folder/*.fasta
            do
                run_dbcan $assembly meta \
                    --out_dir /path/to/output/dir/dbcan_output_"${sample_prefix}${i}" \
                    --db_dir /path/to/installed/databases/
            done
        else
            echo "Directory $sample_folder does not exist."
        fi
    done
done
