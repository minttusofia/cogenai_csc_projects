# Instructions for running projects on CSC clusters  

TL;DR 👀  
We provide CoGenAI participants access to GPUs and CPUs through CSC.  
If you would like to use these for your project, this guide is for you.

------------

Otherwise, you are free to use whatever computing resources (such as your own institution's) are suitable for you.

## 1. Setting up your CSC account
Please see the steps for setting up your CSC account [here](https://github.com/minttusofia/huggingface-llm-tutorial?tab=readme-ov-file#llm-hands-on-session--introduction-to-cscs-puhti-and-mahti-clusters), if you have not yet completed this step.  
After this, you should be able to connect to CSC clusters using `ssh mahti` or `ssh puhti`.

## 2. Scheduling jobs
**Computation should not be done on the login nodes**, so please do not run python, jupyter, etc. there.  

Puhti and Mahti use [Slurm](https://docs.csc.fi/computing/running/submitting-jobs/) to schedule jobs on the compute nodes. If you won't need GPUs for your job, please use either your local machine, or Puhti. (Mahti is best suited for either GPU jobs or very large-scale CPU jobs.)

We provide templates for launch scripts for CPU-only and GPU jobs: `launch_cpu_puhti.sh`, `launch_gpu_puhti.sh` and `launch_gpu_mahti.sh`.  
- Jobs can be launched using `sbatch <launch_script_name>.sh`.  
- You can check if your job is being scheduled using `squeue --me`.  
- To cancel your job, use, `scancel <JOBID>`.
> [!IMPORTANT]
Please try to not leave jobs running once you no longer need them!

## 3. Disk space
The following paths relate to both Mahti and Puhti, but their disks are separate.

Your home directory `/users/$USER` has 10GB of space. The shared project directory in `/scratch/project_2010262` has about 40GB per CoGenAI participant. Let us know if you need more for your use case.

> [!NOTE]
📂 **Please create your own subdirectory for your files with**  
```mkdir /scratch/project_2010262/$USER```  


or add them to `/scratch/project_2010262/shared/` if they may be useful to others (e.g. common datasets). If you find it more convenient to create one directory for your whole team, please use the format `mkdir /scratch/project_2010262/team_{i}`, where `i` is your team's number &ndash; do not create any other top-level directories under our project directory. 

If you use HuggingFace, please set your cache directory with `export HF_HOME=/scratch/project_2010262/shared/huggingface-hub-cache` so models and datasets are only downloaded once.

## 4. Creating conda environments
One conda environment has been pre-created for you:
- for LLM projects: `/projappl/project_2010262/conda_envs/llm_tutorial`

You can activate it by running:
`export PATH="/projappl/project_2010262/conda_envs/llm_tutorial/bin:$PATH"`

### If you need to install additional dependencies, do one of the following:

### A) Copy an existing conda environment :snake:
Please do not directly modify (without first creating a copy) any environments that you didn't create.
```bash
cp -r /PATH/TO/EXISTING/CONDA/ENV /scratch/project_2010262/$USER/NEW/PATH/
```
Then create `update_conda_env.sh`, a bash file where you can add any commands needed, such as `pip install`, `conda install`, ...
```
module load tykky
conda-containerize update /scratch/project_2010262/$USER/NEW/PATH --post-install update_conda_env.sh 
```

### B) Create a conda environment from scratch :snake:
```
module load tykky
conda-containerize new --prefix /scratch/project_2010262/$USER/<install_dir> env.yml
```
where `env.yml` is a yaml file defining your environment's dependencies. See [this guide](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-file-manually) for how to create a yaml file for conda. 

More information on working with conda environments on Puhti / Mahti: [https://docs.csc.fi/computing/containers/tykky/](https://docs.csc.fi/computing/containers/tykky/).

Using Python virtualenvs is also possible (and relatively straight-forward).

## 5. Limiting queueing time for GPUs
With a large cohort of us running jobs at once, wait times may arise. From 8am-3pm on Friday, the project day, we also have 20 GPUs reserved on Puhti specifically for our CSC project. Please make use of these first and foremost if they are free, using the slurm argument `--reservation=ellis-summer-school-2024-fri`, e.g.:
```bash
sbatch launch_gpu_puhti.sh --reservation=ellis-summer-school-2024-fri
```
If all 20 are already in use and you cannot schedule your job within the reservation, leave out this argument to request a GPU in the rest of the cluster.

If your job is still queued, please check Mahti if you cannot get your GPU job scheduled on Puhti and vice versa, or perhaps try your university's own cluster, if applicable, or see if using a GPU runtime through Google Colab is an option for you. Apologies for the hassle.

## Further information
For more documentation on CSC clusters, please see https://docs.csc.fi/support/tutorials/puhti_quick/, https://docs.csc.fi/support/tutorials/mahti_quick/ and https://docs.csc.fi/.
