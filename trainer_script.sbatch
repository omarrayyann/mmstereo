#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=4:00:00
#SBATCH --mem=32GB
#SBATCH --job-name=stereo_train
#SBATCH --output=train.out
#SBATCH --gres=gpu:3

module purge

singularity exec --nv --overlay /scratch/$USER/my_env/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c 'source /ext3/env.sh; conda activate /ext3/py3.8  ;virtualenv -p python3.8 venv; source venv/bin/activate; pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html; pip install -r requirements.txt ;  python3 train.py --config config_sceneflow.yaml --resume_from_checkpoint /scratch/olr7742/StereoDepth/mmstereo-main/output/sceneflow/version_30/checkpoints/last.ckpt'
