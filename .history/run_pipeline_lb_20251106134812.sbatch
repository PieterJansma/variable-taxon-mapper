#!/usr/bin/env bash
#SBATCH -t 01:00:00
#SBATCH -c 4
#SBATCH -J vtmap
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

set -euo pipefail

WORKDIR="/groups/umcg-gcc/tmp02/users/umcg-pjansma/Repositories/variable-taxon-mapper"
VENV="$WORKDIR/.venv"

cd "$WORKDIR"
source "$VENV/bin/activate"

# (optioneel) LLM endpoints voor jouw Mixtral server
# export LLM_BASE_URL="http://127.0.0.1:8080"
# export LLM_MODEL="mixtral-8x7b-instruct-v0.1"
# export LLM_TIMEOUT=600
# export LLM_MAX_TOKENS=900
# export LLM_TEMPERATURE=0.2

python main_solo.py -i ./rapport.txt -o ./biopsy_extract.xlsx

deactivate
