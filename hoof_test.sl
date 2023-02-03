#!/usr/bin/env bash
#SBATCH --account=agresearch03746
#SBATCH --job-name=hoof_sample
#SBATCH --time=00-11:00:00
#SBATCH --gpus-per-node=P100:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=128GB

# load environment modules
module purge
module load Python/3.7.3-gimkl-2018b cuDNN/7.6.5.32-CUDA-10.0.130

# activate the virtual environment
#export PYTHONNOUSERSITE=1
#. ../venv_gpu/bin/activate
export PYTHONNOUSERSITE=True
source /scale_wlg_persistent/filesets/project/agresearch03746/Mask-RCNN-TF2/venv_gpu/bin/activate

# run the script
python hoof_test.py
