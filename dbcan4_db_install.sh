#!/bin/bash
#PBS -N db_install
#PBS -l nodes=1:ppn=15
#PBS -l walltime=15:00:00
#PBS -l mem=100gb
#PBS -j oe
#PBS -o db_install_output.log
#PBS -e db_install_error.log

# Load conda environment
source <path/to/correct/conda.sh>
conda activate run_dbcan

# Install dbcan4 databases
test -d db || mkdir db
cd db \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/fam-substrate-mapping-08252022.tsv \
	&& wget http://bcb.unl.edu/dbCAN2/download/Databases/PUL.faa && makeblastdb -in PUL.faa -dbtype prot \
	&& wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-PUL_07-01-2022.xlsx \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-PUL_07-01-2022.txt \
	&& wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-PUL.tar.gz && tar xvf dbCAN-PUL.tar.gz \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN_sub.hmm && hmmpress dbCAN_sub.hmm \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/V11/CAZyDB.08062022.fa && diamond makedb --in CAZyDB.08062022.fa -d CAZy \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V11/dbCAN-HMMdb-V11.txt && mv dbCAN-HMMdb-V11.txt dbCAN.txt && hmmpress dbCAN.txt \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V11/tcdb.fa && diamond makedb --in tcdb.fa -d tcdb \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/V11/tf-1.hmm && hmmpress tf-1.hmm \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/V11/tf-2.hmm && hmmpress tf-2.hmm \
    && wget https://bcb.unl.edu/dbCAN2/download/Databases/V11/stp.hmm && hmmpress stp.hmm \
    && cd ../ && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.fna \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.faa \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.gff

# Check the program
run_dbcan EscheriaColiK12MG1655.fna prok --out_dir output_EscheriaColiK12MG1655
