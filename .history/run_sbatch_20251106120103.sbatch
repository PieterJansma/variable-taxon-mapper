#!/bin/bash
#SBATCH --job-name=vtm
#SBATCH --nodes=1
#SBATCH --gres=gpu:a40:2
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --qos=interactive
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

# directe, vloeiende output
export PYTHONUNBUFFERED=1
export TQDM_DISABLE=1

# draai je pipeline ongebufferd en log mee
bash ./run_pipeline_lb.sh python -u -m main config.example.toml |& tee run.log
