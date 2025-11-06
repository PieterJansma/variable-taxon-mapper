#!/bin/bash
#SBATCH --job-name=vtm
#SBATCH --nodes=1
#SBATCH --gres=gpu:a40:2
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --qos=interactive
#SBATCH --chdir=/groups/umcg-gcc/tmp02/users/umcg-pjansma/Repositories/variable-taxon-mapper
# Optie A (veilig): laat Slurm in het workdir loggen, geen submap nodig
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

set -euo pipefail

# === Paden ===
WORKDIR="/groups/umcg-gcc/tmp02/users/umcg-pjansma/Repositories/variable-taxon-mapper"
VENV="$WORKDIR/.venv"

cd "$WORKDIR"

# Optie B: eigen extra runtime-log in submap (met SLURM_JOB_ID)
mkdir -p logs

export PYTHONUNBUFFERED=1
export TQDM_DISABLE=1

# === Activeer venv ===
if [[ ! -x "$VENV/bin/python" ]]; then
  echo "ERROR: venv ontbreekt: $VENV" >&2
  exit 1
fi
source "$VENV/bin/activate"

# === (optioneel) LLM endpoints voor je Mixtral setup ===
# export LLM_BASE_URL="http://127.0.0.1:8080"
# export LLM_MODEL="mixtral-8x7b-instruct-v0.1"
# of via LB: export LLM_SERVERS="http://127.0.0.1:18080,http://127.0.0.1:18081"

echo "PWD=$(pwd)"
echo "Python=$(python -V)  Exec=$(command -v python)"

# Gebruik $SLURM_JOB_ID i.p.v. %j hier
# Tip: gebruik srun zodat CPU/GPU-binding netjes is
srun bash ./run_pipeline_lb.sh python -u -m main config.example.toml \
  2>&1 | tee "logs/run-${SLURM_JOB_ID}.log"

deactivate
