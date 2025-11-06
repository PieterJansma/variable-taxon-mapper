#!/bin/bash
#SBATCH --job-name=vtm
#SBATCH --nodes=1
#SBATCH --gres=gpu:a40:2
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --qos=interactive
#SBATCH --chdir=/groups/umcg-gcc/tmp02/users/umcg-pjansma/Repositories/variable-taxon-mapper
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

mkdir -p logs
export PYTHONUNBUFFERED=1
export TQDM_DISABLE=1

# zorg dat we sowieso in de juiste map zitten
echo "PWD=$(pwd)"
bash ./run_pipeline_lb.sh python -u -m main config.example.toml |& tee logs/run-%j.log