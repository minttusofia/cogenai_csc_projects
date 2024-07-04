#!/bin/bash
#SBATCH --account=project_2010262
#SBATCH --partition=gpusmall
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=3:00:00
#SBATCH --gres=gpu:a100:1

# Activate a conda environment.
export PATH="/projappl/project_2010262/conda_envs/llm_tutorial/bin:$PATH"
# Set Huggingface cache directory.
export HF_HOME="/scratch/project_2010262/shared/huggingface-hub-cache"

srun python YOUR_PROGRAM.py
