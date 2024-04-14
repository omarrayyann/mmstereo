#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH --time=1:00:00
#SBATCH --mem=32GB
#SBATCH --job-name=stereo_train
#SBATCH --output=test.out
#SBATCH --gres=gpu:3

module purge

singularity exec --nv --overlay /scratch/$USER/my_env/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c 'source /ext3/env.sh; conda activate /ext3/py3.8  ;virtualenv -p python3.8 venv; source venv/bin/activate; pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html; pip install -r requirements.txt ; python run.py --script output/sceneflow/version_24/checkpoints/model.pt --left datasets/sceneflow/flying_things/val/left/0000000.png --right datasets/sceneflow/flying_things/val/right/0000000.png'
