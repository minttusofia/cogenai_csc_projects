#!/bin/bash
#SBATCH --account=project_2010262
#SBATCH --partition=small
#SBATCH --time=07:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4000

# Activate a conda environment.
export PATH="/projappl/project_2010262/conda_envs/llm_tutorial/bin:$PATH"
# Set Huggingface cache directory.
export HF_HOME="/scratch/project_2010262/shared/huggingface-hub-cache"

srun python YOUR_PROGRAM.py
